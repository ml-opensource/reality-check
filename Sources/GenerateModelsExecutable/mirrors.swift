import ArgumentParser
import Foundation
import Models
import SwiftSyntax
import SwiftSyntaxBuilder

@available(macOS 13.0, *)
struct GenerateMirrors: ParsableCommand {
  static var configuration = CommandConfiguration(
    commandName: "mirrors"
  )

  @Argument(help: "Input file path.")
  var input: String

  @Argument(help: "Output file path.")
  var output: String

  func run() throws {
    let source = URL(string: "file://\(input)")!
    let destination = URL(string: "file://\(output)")!

    let data = try Data(contentsOf: source.appending(path: "Components.json"))
    let _symbols: [_Symbol] = try JSONDecoder().decode([_Symbol].self, from: data)

    //MARK: Templates
    let file = try SourceFileSyntax(
      leadingTrivia: "// This file was automatically generated and should not be edited."
        + .newlines(2)
    ) {
      try ImportDeclSyntax("import CustomDump")
      try ImportDeclSyntax("import RealityKit")

      DeclSyntax(
        """
        #if os(\(raw: source.lastPathComponent))

        //MARK: \(raw: source.lastPathComponent)
        """
      )

      for symbol in _symbols {
        try ExtensionDeclSyntax(
          """
          extension \(raw: symbol.name): CustomDumpReflectable
          """
        ) {
          try VariableDeclSyntax("public var customDumpMirror: Mirror") {
            DeclSyntax(".init(reflecting: self)")
          }
        }
        .with(\.trailingTrivia, .newline)
      }

      DeclSyntax("#endif")
    }

    //MARK: Save
    let fileURL = destination.appending(path: "Component_\(source.lastPathComponent)+Mirror.swift")
    try file.formatted().description.write(to: fileURL, atomically: true, encoding: .utf8)
  }
}
