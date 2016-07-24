import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

let server = HTTPServer()

// Directory to serve client content from
server.documentRoot = "./webroot"

let routes = makeRoutes(root: server.documentRoot)
server.addRoutes(routes)

server.serverPort = 8181

do {
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
