// swift-tools-version:4.0
import PackageDescription

#if os(macOS) || os(iOS) || os(tvOS)
let websocket: Package.Dependency = .package(url: "https://github.com/daltoniam/Starscream", .upToNextMinor(from: "2.0.0"))
let websocketDependency: Target.Dependency = "Starscream"
#else
let websocket: Package.Dependency = .package(url: "https://github.com/Zewo/WebSocketClient.git", .upToNextMinor(from: "0.14.0"))
let websocketDependency: Target.Dependency = "WebSocketClient"
#endif

let package = Package(
    name: "SKRTMAPI",
    products: [
        .library(name: "SKRTMAPI", targets: ["SKRTMAPI"]),
    ],
    dependencies: [
    	.package(url: "https://github.com/SlackKit/SKCore", .upToNextMinor(from: "4.0.0")),
    	.package(url: "https://github.com/SlackKit/SKWebAPI", .upToNextMinor(from: "4.0.0")),
    	websocket
    ],
    targets: [
    	.target(name: "SKRTMAPI", 
    			dependencies: ["SKCore", "SKWebAPI", websocketDependency],
    			path: "Sources")
    ]
)
