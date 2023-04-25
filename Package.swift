// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RealityCheck",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "AppFeature",
            targets: ["AppFeature"]
        ),
        .library(
            name: "RealityDumpClient",
            targets: ["RealityDumpClient"]
        ),

    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            branch: "prerelease/1.0"
        ),
        .package(
            url: "https://github.com/pointfreeco/swift-dependencies",
            from: "0.4.1"
        ),
    ],
    targets: [
        .target(
            name: "AppFeature",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                "RealityDumpClient",
            ]
        ),
        .target(
            name: "RealityDumpClient",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies")
            ]
        ),
        .testTarget(
            name: "AppFeatureTests",
            dependencies: ["AppFeature"]),
    ]
)
