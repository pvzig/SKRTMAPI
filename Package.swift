import PackageDescription

let package = Package(
    name: "SKRTMAPI",
    targets: [
        Target(name: "SKRTMAPI")
    ],
    dependencies: [
        .Package(url: "https://github.com/SlackKit/SKCore", majorVersion: 4),
        .Package(url: "https://github.com/SlackKit/SKWebAPI", majorVersion: 4),
        .Package(url: "https://github.com/vapor/engine.git", majorVersion: 2)
    ]
)
