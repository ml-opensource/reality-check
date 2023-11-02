import ArgumentParser
import Foundation
import SymbolKit

@main
struct RealitySymbolsExecutable: ParsableCommand {
  //  @Flag(help: "Include a counter with each repetition.")
  //  var includeCounter = false
  //
  //  @Option(name: .shortAndLong, help: "The number of times to repeat 'phrase'.")
  //  var count: Int? = nil

  @Argument(help: "Input file path.")
  var input: String

  @Argument(help: "Output file path.")
  var output: String

  mutating func run() throws {
    if #available(macOS 13.0, *) {
      let url_iOS = URL(string: "file://\(input)")!
      print("____:", url_iOS)
      let data = try Data(contentsOf: url_iOS)
      let symbolGraph = try! JSONDecoder().decode(SymbolGraph.self, from: data)

      print("____:", output)

      createEntitiesFile(from: symbolGraph, at: "file://\(output)")

      //}
    } else {
      // Fallback on earlier versions
    }
  }
}
