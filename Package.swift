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
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
    .package(url: "https://github.com/apple/swift-docc-symbolkit", branch: "main"),
    .package(url: "https://github.com/apple/swift-syntax", "508.0.0"..<"510.0.0"),
    .package(url: "https://github.com/pointfreeco/swift-custom-dump", from: "1.1.1"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.0.0"),
    // TODO: remove completely
    // .package(url: "https://github.com/devicekit/DeviceKit.git", from: "5.1.0"),

  ],
  targets: [
    .plugin(
      name: "ExtractSymbols",
      capability: .command(
        intent: .custom(
          verb: "extract-symbols",
          description: "Extracts iOS/macOS/visionOS SDK symbolgraphs"
        ),
        permissions: [
          .writeToPackageDirectory(
            reason:
              "This command is the launching pad for sub-commands that turn symbols into JSON and Swift files faster than you can say 'JSON and Swift files'!"
          )
        ]
      ),
      dependencies: [
        "GenerateModelsExecutable",
        "ProcessSymbolsExecutable",
      ]
    ),
    .executableTarget(
      name: "GenerateModelsExecutable",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        .product(name: "SwiftSyntax", package: "swift-syntax"),
        .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
        "Models",
        "RealityDump",
      ]
    ),
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
    .executableTarget(
      name: "ProcessSymbolsExecutable",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        .product(name: "SymbolKit", package: "swift-docc-symbolkit"),
        "Models",
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
        // .product(name: "DeviceKit", package: "DeviceKit", condition: .when(platforms: [.iOS])),
        "RealityCodable",
        "RealityDump",
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
    .target(
      name: "RealitySymbols",
      resources: [
        .copy("Processed")
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
