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
      name: "RealitySymbols",
      targets: ["RealitySymbols"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
    .package(url: "https://github.com/apple/swift-docc-symbolkit", branch: "main"),
    // TODO: remove completely
    // .package(url: "https://github.com/devicekit/DeviceKit.git", from: "5.1.0"),
    .package(url: "https://github.com/pointfreeco/swift-custom-dump", from: "1.1.0"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.0.0"),
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
              "This command write the new extracted JSON files to the extracted directory inside RealitySymbols."
          )
        ]
      )
    ),
    .plugin(
      name: "ProcessSymbols",
      capability: .buildTool(),
      dependencies: [
        "ProcessSymbolsExecutable"
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
      resources: [
        .copy("Processed")
      ],
      plugins: [
        .plugin(name: "ProcessSymbols")
      ]
    ),
    .testTarget(
      name: "RealitySymbolsTests",
      dependencies: ["RealitySymbols"]
    ),
    .executableTarget(
      name: "ProcessSymbolsExecutable",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        .product(name: "SymbolKit", package: "swift-docc-symbolkit")
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
