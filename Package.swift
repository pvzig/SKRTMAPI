import PackageDescription

let package = Package(
    name: "SKRTMAPI",
    targets: [
        Target(name: "SKRTMAPI")
    ],
    dependencies: [
        .Package(url: "https://github.com/SlackKit/SKCore", "4.0.0"),
        .Package(url: "https://github.com/SlackKit/SKWebAPI", "4.0.0")
    ]
)

var dependency: Package.Dependency
#if os(macOS) || os(iOS) || os(tvOS)
dependency = .Package(url: "https://github.com/daltoniam/Starscream", majorVersion: 2)
#else
dependency = .Package(url: "https://github.com/noppoMan/Prorsum.git", "0.1.12")
#endif
package.dependencies.append(dependency)
