from mitmproxy import ctx, http
import threading
import socketserver


class ThreadedTCPRequestHandler(socketserver.BaseRequestHandler):
    def handle(self):
        data = str(self.request.recv(1024), 'ascii')
        cur_thread = threading.current_thread()
        response = bytes("{}: {}".format(cur_thread.name, data), 'ascii')
        self.request.sendall(response)


class ThreadedTCPServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
    allow_reuse_address = True

    def __init__(self, host_port_tuple, streamhandler, controller):
        super().__init__(host_port_tuple, streamhandler)
        self.controller = controller


class Controller(object):
    def __init__(self):
        self.text = "Hello"


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
        ctx.log.info("Request: {}".format(self.controller.text))

    def response(self, flow: http.HTTPFlow) -> None:
        pass

    def done(self):
        if self.server is not None:
            self.server.shutdown()
            self.server = None
        ctx.log.info("Finish")


addons = [ProfessosEnhancer()]
