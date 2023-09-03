// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "reality-check",
  platforms: [
    .iOS(.v15),
    .macOS(.v12),
    .visionOS(.v1),
  ],
  products: [
    .library(
      name: "RealityCheckConnect",
      targets: ["RealityCheckConnect"]
    ),
    .library(
      name: "RealityDumpClient",
      targets: ["RealityDumpClient"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/devicekit/DeviceKit.git", from: "5.0.0"),
    .package(url: "https://github.com/pointfreeco/swift-custom-dump", from: "1.0.0"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.0.0"),
  ],
  targets: [
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
        .target(name: "RealityCheckConnect_visionOS", condition: .when(platforms: [.visionOS])),
        .target(name: "RealityCheckConnect_iOS", condition: .when(platforms: [.iOS])),  //FIXME: still compiled for `visionOS`
      ]
    ),
    .target(
      name: "RealityCheckConnect_iOS",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies"),
        .product(name: "DeviceKit", package: "DeviceKit", condition: .when(platforms: [.iOS])),
        "Models",
        "MultipeerClient",
        "RealityDumpClient",
        "StreamingClient",
      ]
    ),
    .target(
      name: "RealityCheckConnect_visionOS",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies"),
        "Models",
        "MultipeerClient",
        "RealityDumpClient",
        "StreamingClient",
      ]
    ),
    .target(
      name: "RealityDumpClient",
      dependencies: [
        .product(name: "CustomDump", package: "swift-custom-dump"),
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
