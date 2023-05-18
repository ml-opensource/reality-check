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
      name: "Models",
      targets: ["Models"]
    ),
    .library(
      name: "MultipeerClient",
      targets: ["MultipeerClient"]
    ),
    .library(
      name: "RealityCheckConnect",
      targets: ["RealityCheckConnect"]
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
      url: "https://github.com/pointfreeco/swift-dependencies",
      from: "0.5.0"
    )
  ],
  targets: [
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
      name: "RealityCheckConnect",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies"),
        "MultipeerClient",
        "RealityDumpClient",
        "StreamingClient",
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
      ]
    ),
  ]
)
