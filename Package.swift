// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "SKRTMAPI",
    products: [
        .library(name: "SKRTMAPI", targets: ["SKRTMAPI"])
    ],
    dependencies: [
        .package(url: "https://github.com/SlackKit/SKCore", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/SlackKit/SKWebAPI", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/vapor/engine", .upToNextMajor(from: "2.2.2")),
    ],
    targets: [
        .target(name: "SKRTMAPI", dependencies: ["SKCore", "SKWebAPI", "WebSockets", "HTTP", "URI"])
    ]
)
