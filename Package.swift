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
      name: "Models",
      targets: ["Models"]
    ),
    .library(
      name: "MultipeerClient",
      targets: ["MultipeerClient"]
    ),
    .library(
      name: "RealityDumpClient",
      targets: ["RealityDumpClient"]
    ),
    .library(
      name: "StreamingClient",
      targets: ["StreamingClient"]
    ),
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
        .product(name: "MessagePack", package: "MessagePack"),
        "Models",
        "RealityDumpClient",
      ]
    ),
    .testTarget(
      name: "AppFeatureTests",
      dependencies: ["AppFeature"]
    ),
    .target(
      name: "Models",
      dependencies: []
    ),
    .target(
      name: "MultipeerClient",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies")
      ]
    ),
    .target(
      name: "RealityDumpClient",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies"),
        "Models",
      ]
    ),
    .target(
      name: "StreamingClient",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies")
      ],
      resources: [
        .process("Renderer/Shaders")
      ]
      // publicHeadersPath: "Renderer/Shaders"
    ),
  ]
)
