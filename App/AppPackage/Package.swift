// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AppPackage",
  platforms: [
    .macOS(.v12)
  ],
  products: [
    .library(
      name: "AppFeature",
      targets: ["AppFeature"]
    )
  ],
  dependencies: [
    .package(
      url: "https://github.com/Flight-School/MessagePack",
      from: "1.2.4"
    ),
    .package(
      url: "https://github.com/pointfreeco/swift-composable-architecture",
      branch: "prerelease/1.0"
    ),
    .package(path: "../RealityCheck")
  ],
  targets: [
    .target(
      name: "AppFeature",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "MessagePack", package: "MessagePack"),
        .product(name: "Models", package: "RealityCheck"),
        .product(name: "MultipeerClient", package: "RealityCheck"),
        .product(name: "RealityDumpClient", package: "RealityCheck"),
        .product(name: "StreamingClient", package: "RealityCheck"),
      ]
    ),
    .testTarget(
      name: "AppFeatureTests",
      dependencies: ["AppFeature"]
    ),
  ]
)
