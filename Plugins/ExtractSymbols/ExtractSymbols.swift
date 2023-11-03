import Foundation
import PackagePlugin

@main
struct ExtractSymbols: CommandPlugin {
  func performCommand(context: PackagePlugin.PluginContext, arguments: [String]) async throws {
    try extractSymbolGraph(from: xcodePath(), context: context)
    try processSymbols(context: context)

    print(">>>>>: GenerateCodable")

    let generateCodable = Process()
    let generateCodableTool = try context.tool(named: "GenerateCodableExecutable").path
    generateCodable.executableURL = URL(fileURLWithPath: generateCodableTool.string)
    generateCodable.arguments = []
    try generateCodable.run()
    generateCodable.waitUntilExit()
  }
}

//MARK: - Find Xcode path

extension ExtractSymbols {
  func xcodePath() throws -> Path {
    let xcodeSelect = Process()
    let pipe = Pipe()
    xcodeSelect.launchPath = "/usr/bin/env"
    xcodeSelect.arguments = ["xcode-select", "-p"]
    xcodeSelect.standardOutput = pipe
    try xcodeSelect.run()
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let xcodePathString = String(data: data, encoding: .utf8)!
      .trimmingCharacters(in: .whitespacesAndNewlines)
    xcodeSelect.waitUntilExit()
    return Path(xcodePathString)
  }
}

//MARK: - Extract SDKs from Xcode

extension ExtractSymbols {
  func extractSymbolGraph(from xcodePath: Path, context: PackagePlugin.PluginContext) throws {
    for platform in _Platform.allCases {
      let symbolgraphExtract = Process()
      let swiftTool = try context.tool(named: "swift").path
      symbolgraphExtract.executableURL = URL(fileURLWithPath: swiftTool.string)
      symbolgraphExtract.arguments = [
        "symbolgraph-extract",
        "-module-name", "RealityFoundation",
        "-target", platform.target,
        "-output-dir", "\(context.package.directory.appending(platform.extractedDirectory))",
        "-sdk", "\(xcodePath.appending(platform.sdk))",
      ]
      try symbolgraphExtract.run()
      symbolgraphExtract.waitUntilExit()
    }
  }
}

//MARK: - Process Symbols

extension ExtractSymbols {
  func processSymbols(context: PackagePlugin.PluginContext) throws {
    for platform in _Platform.allCases {
      let processSymbols = Process()
      let processSymbolsTool = try context.tool(named: "ProcessSymbolsExecutable").path
      processSymbols.executableURL = URL(fileURLWithPath: processSymbolsTool.string)

      processSymbols.arguments = [
        "\(context.package.directory.appending(platform.extractedDirectory))",
        "\(context.package.directory.appending(platform.processedDirectory))",
      ]
      try processSymbols.run()
      processSymbols.waitUntilExit()
    }
  }
}

//MARK: -

extension ExtractSymbols {
  enum _Platform: CaseIterable {
    case iOS
    case macOS
    case visionOS

    var target: String {
      switch self {
        case .iOS:
          return "arm64-apple-ios"
        case .macOS:
          return "arm64-apple-macos"
        case .visionOS:
          return "arm64-apple-xros"
      }
    }

    var extractedDirectory: String {
      switch self {
        case .iOS:
          return "Sources/RealitySymbols/Extracted/iOS"
        case .macOS:
          return "Sources/RealitySymbols/Extracted/macOS"
        case .visionOS:
          return "Sources/RealitySymbols/Extracted/visionOS"
      }
    }

    var processedDirectory: String {
      switch self {
        case .iOS:
          return "Sources/RealitySymbols/Processed/iOS"
        case .macOS:
          return "Sources/RealitySymbols/Processed/macOS"
        case .visionOS:
          return "Sources/RealitySymbols/Processed/visionOS"
      }
    }

    var sdk: String {
      switch self {
        case .iOS:
          return "Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk"
        case .macOS:
          return "Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"
        case .visionOS:
          return "Platforms/XROS.platform/Developer/SDKs/XROS.sdk"
      }
    }
  }

}
