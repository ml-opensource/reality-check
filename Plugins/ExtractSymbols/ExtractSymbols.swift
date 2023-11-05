import Foundation
import PackagePlugin

@main
struct ExtractSymbols: CommandPlugin {
  func performCommand(context: PackagePlugin.PluginContext, arguments: [String]) async throws {
//    try extractSymbolGraph(from: xcodePath(), context: context)
//    try processSymbols(context: context)
//    try generateModels(context: context)
//    try generateMirrors(context: context)
    try generateCodable(context: context)
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

//MARK: - Extract SDK

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

//MARK: - Generate Models

extension ExtractSymbols {
  func generateModels(context: PackagePlugin.PluginContext) throws {
    for platform in _Platform.allCases {
      let generateCodable = Process()
      let generateCodableTool = try context.tool(named: "GenerateModelsExecutable").path
      generateCodable.executableURL = URL(fileURLWithPath: generateCodableTool.string)
      generateCodable.arguments = [
        "component-type",
        "\(context.package.directory.appending(platform.processedDirectory))",
        "\(context.package.directory.appending(platform.modelsDirectory))",
      ]
      try generateCodable.run()
      generateCodable.waitUntilExit()
    }
  }
}

//MARK: - Generate Codable

extension ExtractSymbols {
  func generateCodable(context: PackagePlugin.PluginContext) throws {
    for platform in _Platform.allCases {
      let generateCodable = Process()
      let generateCodableTool = try context.tool(named: "GenerateModelsExecutable").path
      generateCodable.executableURL = URL(fileURLWithPath: generateCodableTool.string)
      generateCodable.arguments = [
        "component-codable",
        "\(context.package.directory.appending(platform.processedDirectory))",
        "\(context.package.directory.appending(platform.codableDirectory))",
      ]
      try generateCodable.run()
      generateCodable.waitUntilExit()
    }
  }
}

//MARK: - Generate Mirrors

extension ExtractSymbols {
  func generateMirrors(context: PackagePlugin.PluginContext) throws {
    for platform in _Platform.allCases {
      let generateCodable = Process()
      let generateCodableTool = try context.tool(named: "GenerateModelsExecutable").path
      generateCodable.executableURL = URL(fileURLWithPath: generateCodableTool.string)
      generateCodable.arguments = [
        "mirrors",
        "\(context.package.directory.appending(platform.processedDirectory))",
        "\(context.package.directory.appending(platform.realityDumpDirectory))",
      ]
      try generateCodable.run()
      generateCodable.waitUntilExit()
    }
  }
}
