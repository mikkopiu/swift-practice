import PackageDescription

let package = Package(
	name: "WebSockets",
        dependencies: [
                .Package(url:"https://github.com/PerfectlySoft/Perfect-HTTPServer.git", versions: Version(0,0,0)..<Version(10,0,0)),
                .Package(url:"https://github.com/PerfectlySoft/Perfect-WebSockets.git", versions: Version(0,0,0)..<Version(10,0,0))
        ]
)
