import ArgumentParser
import Foundation
import Models
import SwiftSyntax
import SwiftSyntaxBuilder

@available(macOS 13.0, *)
struct GenerateComponentType: ParsableCommand {
  static var configuration = CommandConfiguration(
    commandName: "component-type"
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
      try ImportDeclSyntax("import Foundation")
      try ImportDeclSyntax("import RealityKit")
      
      try ExtensionDeclSyntax(
        """
        //MARK: \(raw: source.lastPathComponent)

        extension RealityPlatform.\(raw: source.lastPathComponent)
        """
      ) {
        try EnumDeclSyntax(
          """
          public enum ComponentType: CaseIterable
          """
        ) {
          for symbol in _symbols {
            try EnumCaseDeclSyntax(
              """
              case \(raw: symbol.name.withFirstLetterLowercased())
              """
            )
          }
        }
      }

      DeclSyntax("#if os(\(raw: source.lastPathComponent))")

      try ExtensionDeclSyntax(
        """
        extension RealityPlatform.\(raw: source.lastPathComponent).ComponentType
        """
      ) {
        try VariableDeclSyntax("public var rawType: RealityKit.Component.Type") {
          try SwitchExprSyntax("switch self") {
            for symbol in _symbols {
              SwitchCaseSyntax(
                """
                case .\(raw: symbol.name.withFirstLetterLowercased()):
                  return \(raw: symbol.name).self
                """
              )
            }
          }
        }
      }
      .with(\.trailingTrivia, .newline)

      DeclSyntax("#endif")
    }

    //MARK: Save
    let fileURL = destination.appending(path: "ComponentType_\(source.lastPathComponent).swift")
    try file.formatted().description.write(to: fileURL, atomically: true, encoding: .utf8)
  }
}
