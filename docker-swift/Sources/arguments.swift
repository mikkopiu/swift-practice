import PerfectHTTPServer
import PerfectLib
import SwiftGlibc

func configureServer(_ server: HTTPServer) {
    var args = Process.arguments

    func argFirst() -> String {
        guard let frst = args.first else {
            print("Argument requires value.")
            exit(-1)
        }
        return frst
    }

    let validArgs = [
        "--port": {
            args.removeFirst()
            server.serverPort = UInt16(argFirst()) ?? 8181
        },
        "--address": {
            args.removeFirst()
            server.serverAddress = argFirst()
        }
    ]

    while args.count > 0 {
        if let closure = validArgs[args.first!.lowercased()] {
            closure()
        }
        args.removeFirst()
    }
}

