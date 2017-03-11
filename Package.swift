import PackageDescription

let package = Package(
    name: "SKRTMAPI",
    targets: [
        Target(name: "SKRTMAPI", dependencies: [
            "SKCore",
            "SKWebAPI"
        ])
    ],
    dependencies: [
        .Package(url: "https://github.com/SlackKit/SKCore", "4.0.0"),
        .Package(url: "https://github.com/SlackKit/SKWebAPI", "4.0.0"),
        .Package(url: "https://github.com/Zewo/WebSocketClient", majorVersion: 0)
    ]
)

#if os(macOS) || os(iOS) || os(tvOS)
let dependency = Package.Dependency(url: "https://github.com/daltoniam/Starscream", majorVersion: 2)
package.dependencies.append(dependency)
#endif
