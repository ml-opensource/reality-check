import ArgumentParser
import Foundation
import Models
import SwiftSyntax
import SwiftSyntaxBuilder

@main
@available(macOS 13.0, *)
struct GenerateModels: ParsableCommand {

  @Argument(help: "Input file path.")
  var input: String

  @Argument(help: "Output file path.")
  var output: String

  mutating func run() throws {
    let source = URL(string: "file://\(input)")!
    let destination = URL(string: "file://\(output)")!
    try generateComponentTypeModels(source: source, at: destination)
  }

  func generateComponentTypeModels(source: URL, at path: URL) throws {
    let data = try Data(contentsOf: source.appending(path: "Components.json"))
    let _symbols: [_Symbol] = try JSONDecoder().decode([_Symbol].self, from: data)

    let file = try SourceFileSyntax(
      leadingTrivia: "// This file was automatically generated and should not be edited."
        + .newlines(2)
    ) {
      DeclSyntax(
        """
        import Foundation
        import RealityKit
        """
      )
      .with(\.trailingTrivia, .newline)

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

      DeclSyntax(
        """
        #if os(\(raw: source.lastPathComponent))
        """
      )

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

      DeclSyntax(
        """
        #endif
        """
      )
    }

    let fileURL = path.appendingPathComponent(
      "/ComponentType_\(source.lastPathComponent).swift"
    )
    try file.formatted().description.write(to: fileURL, atomically: true, encoding: .utf8)
  }
}

extension String {
  func withFirstLetterUppercased() -> String {
    if let firstLetter = self.first {
      return firstLetter.uppercased() + self.dropFirst()
    } else {
      return self
    }
  }
}

extension String {
  func withFirstLetterLowercased() -> String {
    if let firstLetter = self.first {
      return firstLetter.lowercased() + self.dropFirst()
    } else {
      return self
    }
  }
}
