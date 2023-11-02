import ArgumentParser
import Foundation

@main
struct RealitySymbolsExecutable: ParsableCommand {
  //  @Flag(help: "Include a counter with each repetition.")
  //  var includeCounter = false
  //
  //  @Option(name: .shortAndLong, help: "The number of times to repeat 'phrase'.")
  //  var count: Int? = nil

  @Argument(help: "The phrase to repeat.")
  var phrase: String

//  @Argument(help: "The input file.")
//  var inputFiles: String

  mutating func run() throws {
    print(CommandLine.arguments)
    print("something .... EEVEN \(phrase)")
  }
}

//  static func main() {
//    let inputFile = ProcessInfo.processInfo.environment
//    print("something .... EEVEN")
//    dump(inputFile)
//  }
