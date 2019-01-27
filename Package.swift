// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "SKRTMAPI",
    products: [
        .library(name: "SKRTMAPI", targets: ["SKRTMAPI"])
    ],
    dependencies: [
        .package(url: "https://github.com/pvzig/SKCore", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/pvzig/SKWebAPI", .upToNextMajor(from: "4.0.0"))
    ],
    targets: []
)

var dependency: Package.Dependency
var target: Target
#if os(macOS) || os(iOS) || os(tvOS)
target = .target(name: "SKRTMAPI", dependencies: ["SKCore", "SKWebAPI", "Starscream"])
dependency = .package(url: "https://github.com/daltoniam/Starscream", .upToNextMajor(from: "3.0.0"))
#else
target = .target(name: "SKRTMAPI", dependencies: ["SKCore", "SKWebAPI", "WebSockets", "HTTP", "URI"])
dependency = .package(url: "https://github.com/vapor/engine", .upToNextMajor(from: "2.2.2"))
#endif
package.dependencies.append(dependency)
package.targets.append(target)
