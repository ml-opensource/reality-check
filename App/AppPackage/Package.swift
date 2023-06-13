// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AppPackage",
  platforms: [
    .macOS(.v13)
  ],
  products: [
    .library(
      name: "AppFeature",
      targets: ["AppFeature"]
    )
  ],
  dependencies: [
    .package(
      url: "https://github.com/pointfreeco/swift-composable-architecture",
      branch: "prerelease/1.0"
    ),
    .package(name: "reality-check", path: "../.."),
  ],
  targets: [
    .target(
      name: "AppFeature",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "RealityCheckConnect", package: "reality-check"),
      ]
    ),
    .testTarget(
      name: "AppFeatureTests",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "AppFeature",
      ],
      resources: [
        .copy("Resources/simple_hierarchy.json"),
        .copy("Resources/not_so_simple_hierarchy.json"),
      ]
    ),
  ]
)
