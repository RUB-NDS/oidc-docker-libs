from mitmproxy import ctx, http
import base64
import json
import threading
import socketserver

from urllib.parse import urlparse, quote


class CMDDef:
    TYPE_CLEAR = "clear"
    TYPE_REQUEST = "request"

    QUERY_SEARCH_REPLACE = "querySearchReplace"
    JWKS_SPOOFING = "jwksSpoofing"


class Intercept:
    def __init__(self, search, replace):
        self.search = base64.b64decode(search).decode('ascii')
        self.replace = base64.b64decode(replace).decode('ascii')


class InterceptReplaceCommand:
    def __init__(self, uri, keyVal):
        self.type = CMDDef.TYPE_REQUEST
        self.action = CMDDef.QUERY_SEARCH_REPLACE
        self.uri = uri
        self.keyVal = keyVal

    def replace(self, requestUri):
        parse = urlparse(requestUri)

        # Check if url same
        if self.uri != parse.netloc+parse.path:
            return None

        querys = parse.query.split("&")
        new_query = []
        for query in querys:
            key, value = query.split('=')
            print(self.keyVal)
            if key in self.keyVal:
                print(key)
                value = self.keyVal.get(key)
            query = key + '=' + quote(value)
            new_query.append(query)

        new_query = "&".join(new_query)
        return parse._replace(query=new_query).geturl()


class InterceptJWKSCommand:
    def __init__(self, uri, keys):
        self.type = CMDDef.TYPE_REQUEST
        self.action = CMDDef.JWKS_SPOOFING
        self.uri = uri
        self.keys = keys


class ThreadedTCPRequestHandler(socketserver.StreamRequestHandler):

    def handle(self):
        data = str(self.rfile.readline(), 'ascii')  # recv until finish \n
        cmd = json.loads(data)
        if cmd.get("type") == CMDDef.TYPE_CLEAR:
            self.server.controller.clear()
        elif cmd.get("type") == CMDDef.TYPE_REQUEST:
            self.server.controller.requestInterceptor = self.request_selection(cmd)
        elif cmd.get("type") == 'response':
            intercept = Intercept(cmd.get('search'), cmd.get('replace'))
            self.server.controller.responseInterceptor = intercept

        response = bytes("OK", 'ascii')
        self.request.sendall(response)

    def request_selection(self, cmd):
        intercept = None
        if cmd.get("action") == CMDDef.QUERY_SEARCH_REPLACE:
            intercept = InterceptReplaceCommand(cmd.get('uri'), cmd.get('keyVal'))
        elif cmd.get("action") == CMDDef.JWKS_SPOOFING:
            intercept = InterceptJWKSCommand(cmd.get('uri'), cmd.get('keys'))
        return intercept


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
        for intercept in self.controller.requestInterceptor:
            if intercept.action == CMDDef.QUERY_SEARCH_REPLACE:
                replaceUrl = intercept.replace(flow.request.pretty_url)
                if replaceUrl:
                    flow.request.url = replaceUrl
                    ctx.log.info("Request Replaced: {}".format(flow.request.pretty_url))
            elif intercept.action == CMDDef.JWKS_SPOOFING:
                #ctx.log.info("Intercept URI: {} -> {}".format(flow.request.pretty_url, intercept.uri))
                if flow.request.pretty_url == intercept.uri:
                    ctx.log.info("{}".format({"keys": intercept.keys}))

                    keys = {"keys": intercept.keys}
                    header = {
                        "Access-Control-Allow-Origin": "*",
                        "Access-Control-Allow-Credentials": "true",
                        "Access-Control-Allow-Methods": "*",
                        "Access-Control-Allow-Headers": "origin, content-type, accept, authorization",
                        "Content-Type": "application/json;charset=UTF-8",
                    }

                    flow.response = http.HTTPResponse.make(
                        200,
                        json.dumps(keys, indent=4, ensure_ascii=False).encode('utf-8'),
                        header
                    )

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
