import Foundation
import PackagePlugin

@main
struct ProcessSymbols: BuildToolPlugin {
  func createBuildCommands(
    context: PackagePlugin.PluginContext,
    target: PackagePlugin.Target
  ) async throws -> [PackagePlugin.Command] {

    dump(context.pluginWorkDirectory)

    let executablePath = try context.tool(named: "ProcessSymbolsExecutable").path
   // let myCommand = try MyCommand.parse([inputFile])
    print("context.package.directory:", context.package.directory)
    print("context.pluginWorkDirectory:", context.pluginWorkDirectory)
    print("target.directory:", target.directory)

    return [
      .buildCommand(
        displayName: "Generating from",
        executable: executablePath,
        arguments: [
          "HELLO"
        ],
        inputFiles: [context.pluginWorkDirectory],
        outputFiles: []
      )
    ]
  }
}
