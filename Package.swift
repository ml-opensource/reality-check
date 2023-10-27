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
    )
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-docc-symbolkit.git", branch: "main"),
    .package(url: "https://github.com/devicekit/DeviceKit.git", from: "5.1.0"),
    .package(url: "https://github.com/pointfreeco/swift-custom-dump", from: "1.1.0"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.0.0"),
  ],
  targets: [
    .target(name: "Models"),
    .target(
      name: "MultipeerClient",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies")
      ],
      resources: [
        .copy("Resources/Mock")
      ]
    ),
    .target(
      name: "RealityCheckConnect",
      dependencies: [
        .target(
          name: "RealityCheckConnect_visionOS",
          condition: .when(platforms: [.visionOS])
        ),
        .target(
          name: "RealityCheckConnect_iOS",
          condition: .when(platforms: [.iOS])
        ),
      ]
    ),
    .target(
      name: "RealityCheckConnect_iOS",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies"),
        .product(name: "DeviceKit", package: "DeviceKit", condition: .when(platforms: [.iOS])),
        "Models",
        "MultipeerClient",
        "StreamingClient",
      ]
    ),
    .target(
      name: "RealityCheckConnect_visionOS",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies"),
        "RealityCodable",
        "RealityDump",
        "Models",
        "MultipeerClient",
        "StreamingClient",
      ]
    ),
    .target(
      name: "RealityCodable",
      dependencies: [
        "RealityDump",
        "Models",
      ]
    ),
    .testTarget(
      name: "RealityCodableTests",
      dependencies: [
        "RealityCodable"
      ]
    ),
    .target(
      name: "RealityDump",
      dependencies: [
        .product(name: "CustomDump", package: "swift-custom-dump"),
        "Models",
      ]
    ),
    .testTarget(
      name: "RealityDumpTests",
      dependencies: [
        "RealityDump"
      ]
    ),
    .target(
      name: "RealitySymbols",
      dependencies: [
        .product(name: "SymbolKit", package: "swift-docc-symbolkit")
      ],
      resources: [
        .copy("Extracted")
      ]
    ),
    .testTarget(
      name: "RealitySymbolsTests",
      dependencies: ["RealitySymbols"]
    ),
    .target(
      name: "StreamingClient",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies")
      ]
    ),
  ]
)
