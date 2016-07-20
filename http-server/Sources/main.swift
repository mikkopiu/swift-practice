import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

// Create HTTP server.
let server = HTTPServer()

var routes = Routes()
routes.add(method: .get, uri: "/", handler: {
        request, response in
        response.appendBody(string: "<html><title>Hello, world!</title><body><h1>Hello, world!</h1></body></html>")
        response.completed()
    }
)

server.addRoutes(routes)

server.serverPort = 8181

configureServer(server)

do {
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
