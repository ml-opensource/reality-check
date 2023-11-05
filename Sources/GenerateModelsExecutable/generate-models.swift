import ArgumentParser
import Foundation

@main
@available(macOS 13.0, *)
struct GenerateModels: ParsableCommand {

  static var configuration = CommandConfiguration(
    commandName: "generate-models",
    abstract: "This tool produces Swift files from processed symbol graphs.",
    subcommands: [
      GenerateComponentType.self,
      GenerateMirrors.self,
      GenerateComponentCodable.self,
    ]
  )
}
