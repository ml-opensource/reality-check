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
      url: "https://github.com/Flight-School/MessagePack",
      from: "1.2.4"
    ),
    .package(
      url: "https://github.com/pointfreeco/swift-composable-architecture",
      branch: "prerelease/1.0"
    ),
    .package(path: "../RealityCheck"),
    .package(url: "https://github.com/nnabeyang/swift-msgpack", from: "0.2.5"),
  ],
  targets: [
    .target(
      name: "AppFeature",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
//        .product(name: "MessagePack", package: "MessagePack"),
        .product(name: "Models", package: "RealityCheck"),
        .product(name: "MultipeerClient", package: "RealityCheck"),
        .product(name: "RealityDumpClient", package: "RealityCheck"),
        .product(name: "StreamingClient", package: "RealityCheck"),
      ]
    ),
    .testTarget(
      name: "AppFeatureTests",
      dependencies: [
        .product(name: "SwiftMsgpack", package: "swift-msgpack"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "AppFeature"
      ],
      resources: [
        .copy("Resources/simple_hierarchy.json"),
        .copy("Resources/not_so_simple_hierarchy.json")
      ]
    ),
  ]
)
