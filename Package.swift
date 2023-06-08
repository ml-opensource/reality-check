// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "reality-check",
  platforms: [
    .macOS(.v12),
    .iOS(.v15),
  ],
  products: [
    .library(
      name: "RealityCheck",
      targets: [
        "RealityCheck",
        "Models",
        "MultipeerClient",
        "RealityDumpClient",
        "StreamingClient",
      ]
    ),
    .library(
      name: "RealityCheckConnect",
      targets: ["RealityCheckConnect"]
    ),
  ],
  dependencies: [
    .package(
      url: "https://github.com/pointfreeco/swift-custom-dump",
      from: "0.10.3"
    ),
    .package(
      url: "https://github.com/pointfreeco/swift-dependencies",
      from: "0.5.0"
    ),
    .package(
      url: "https://github.com/devicekit/DeviceKit.git",
      from: "5.0.0"
    ),
  ],
  targets: [
    .target(
      name: "RealityCheck",
      dependencies: [
        "Models",
        "MultipeerClient",
        "RealityDumpClient",
        "StreamingClient",
      ]
    ),
    .target(
      name: "Models",
      dependencies: [
        .product(name: "CustomDump", package: "swift-custom-dump")
      ]
    ),
    .target(
      name: "MultipeerClient",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies")
      ],
      resources: [
        .copy("Resources/Mock/simple_arview.json"),
        .copy("Resources/Mock/not_so_simple_arview.json"),
      ]
    ),
    .target(
      name: "RealityCheckConnect",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies"),
        .product(
          name: "DeviceKit",
          package: "DeviceKit",
          condition: .when(platforms: [.iOS])
        ),
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
