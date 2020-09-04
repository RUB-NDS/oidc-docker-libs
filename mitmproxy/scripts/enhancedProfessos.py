from mitmproxy import ctx, http
import base64
import json
import threading
import socketserver


class Intercept:
    def __init__(self, search, replace):
        self.search = base64.b64decode(search).decode('ascii')
        self.replace = base64.b64decode(replace).decode('ascii')


class ThreadedTCPRequestHandler(socketserver.BaseRequestHandler):

    def handle(self):
        data = str(self.request.recv(1024), 'ascii')
        cmd = json.loads(data)

        if cmd.get("type") == 'clear':
            self.server.controller.clear()
        elif cmd.get("type") == 'request':
            intercept = Intercept(cmd.get('search'), cmd.get('replace'))
            self.server.controller.requestInterceptor = intercept
        elif cmd.get("type") == 'response':
            intercept = Intercept(cmd.get('search'), cmd.get('replace'))
            self.server.controller.responseInterceptor = intercept

        response = bytes("OK", 'ascii')
        self.request.sendall(response)


class ThreadedTCPServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
    allow_reuse_address = True

    def __init__(self, host_port_tuple, streamhandler, controller):
        super().__init__(host_port_tuple, streamhandler)
        self.controller = controller


class Controller(object):
    def __init__(self):
        self.__requestInterceptor = []
        self.__responseInterceptor = []

    def clear(self):
        self.__requestInterceptor.clear()
        self.__responseInterceptor.clear()

    @property
    def requestInterceptor(self):
        return self.__requestInterceptor

    @requestInterceptor.setter
    def requestInterceptor(self, value):
        self.__requestInterceptor.append(value)

    @property
    def responseInterceptor(self):
        return self.__responseInterceptor

    @responseInterceptor.setter
    def responseInterceptor(self, value):
        self.__responseInterceptor.append(value)


class ProfessosEnhancer(object):

    def __init__(self) -> None:
        ctx.log.info("Init Server")
        self.controller = Controller()
        self.server = None

    def running(self):
        if self.server is not None:
            ctx.log.info("Server is already running")
            return
        HOST, PORT = "0.0.0.0", 8042
        self.server = ThreadedTCPServer((HOST, PORT), ThreadedTCPRequestHandler, self.controller)
        ip, port = self.server.server_address

        server_thread = threading.Thread(target=self.server.serve_forever)
        server_thread.daemon = True
        server_thread.start()
        ctx.log.info("Enhancer listens on {}:{}".format(ip,port))

    def request(self, flow: http.HTTPFlow) -> None:
        #ctx.log.info("Request {}".format(flow.request.pretty_url))
        for intercept in self.controller.requestInterceptor:
            ctx.log.info("Request {}".format(intercept.search))
            if flow.request.pretty_url == intercept.search:
                #flow.request.url
                pass

    def response(self, flow: http.HTTPFlow) -> None:
        for intercept in self.controller.responseInterceptor:
            ctx.log.info("{}".format(intercept.search))
            if flow.request.pretty_url == intercept.search:
                #flow.response = http.HTTPResponse.make(status, content, header)
                pass

    def done(self):
        if self.server is not None:
            self.server.shutdown()
            self.server = None
        ctx.log.info("Finish")


addons = [ProfessosEnhancer()]
