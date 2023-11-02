import ArgumentParser
import Foundation
import SymbolKit

@main
struct RealitySymbolsExecutable: ParsableCommand {
  @Argument(help: "Input file path.")
  var input: String

  @Argument(help: "Output file path.")
  var output: String

  mutating func run() throws {
    let url = URL(string: "file://\(input)/RealityFoundation.symbols.json")!
    let data = try Data(contentsOf: url)
    let symbolGraph = try JSONDecoder().decode(SymbolGraph.self, from: data)

    createEntitiesFile(from: symbolGraph, at: output)
    createComponentsFile(from: symbolGraph, at: output)
  }
}
