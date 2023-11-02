import Foundation
import PackagePlugin

@main
struct ProcessSymbols: BuildToolPlugin {
  func createBuildCommands(
    context: PackagePlugin.PluginContext,
    target: PackagePlugin.Target
  ) async throws -> [PackagePlugin.Command] {
    let executablePath = try context.tool(named: "ProcessSymbolsExecutable").path
    
    print(context.pluginWorkDirectory)
        
    let input = target.directory.appending("Extracted")
    let output = target.directory.appending("Processed")

    return [
      .buildCommand(
        displayName: "Process Symbols",
        executable: executablePath,
        arguments: [
          input.appending("iOS/RealityFoundation.symbols.json").string,
          output.string,
        ],
        inputFiles: [input],
        outputFiles: [output]
      )
    ]
  }
}
