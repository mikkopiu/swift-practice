import PerfectLib
import PerfectWebSockets
import PerfectHTTP

func makeRoutes(root: String) -> Routes {
    var routes = Routes()

    // Serve static files
    routes.add(method: .get, uri: "*", handler: {
        request, response in StaticFileHandler(documentRoot: root).handleRequest(request: request, response: response)
    })

    // WebSocket route
    routes.add(method: .get, uri: "/hello", handler: {
        request, response in

        // Perfect's boilerplate for creating a route handler
        WebSocketHandler(handlerProducer: {
            (request: HTTPRequest, protocols: [String]) -> WebSocketSessionHandler? in

            // Guard against requests not actually calling the hello-route
            guard protocols.contains("hello") else {
                return nil
            }

            // Return the actual response handler
            return HelloHandler()
        }).handleRequest(request: request, response: response)
    })

    return routes
}

class HelloHandler: WebSocketSessionHandler {
    let socketProtocol: String? = "echo"

    func handleSession(request: HTTPRequest, socket: WebSocket) {
        // Read a client's message,
        // with parameters: data, op-code & is message complete (might be fragmented)
        socket.readStringMessage {
            string, op, fin in

            guard let string = string else {
                socket.close()
                return
            }

            print("Read msg: \(string) op: \(op) fin: \(fin)")

            socket.sendStringMessage(string: string, final: true) {
                self.handleSession(request: request, socket: socket)
            }
        }
    }
}

