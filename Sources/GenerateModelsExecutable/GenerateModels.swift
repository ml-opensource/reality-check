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

    let file = SourceFileSyntax(
      leadingTrivia: "// This file was automatically generated and should not be edited."
        + .newlines(2)
    ) {
      DeclSyntax(
        """
        import Foundation
        import RealityKit
        """
      )
      .with(\.trailingTrivia, .newlines(2))

      try! ExtensionDeclSyntax(
        """
        //MARK: - \(raw: source.lastPathComponent)

        extension RealityPlatform.\(raw: source.lastPathComponent)
        """
      ) {
        try EnumDeclSyntax(
          """
          public enum ComponentType: CaseIterable
          """
        ) {
          for _symbol in _symbols {
            try EnumCaseDeclSyntax(
              """
              case \(raw: _symbol.name.withFirstLetterLowercased())
              """
            )
            .with(\.leadingTrivia, Trivia(pieces: [.newlines(1), .spaces(4)]))
            .with(\.trailingTrivia, .carriageReturn)
          }
        }
        .with(\.leadingTrivia, Trivia(pieces: [.newlines(1), .spaces(2)]))
        .with(\.trailingTrivia, .newline)
      }
    }

    let fileURL = path.appendingPathComponent(
      "/ComponentType_\(source.lastPathComponent).swift"
    )
    try file.description.write(to: fileURL, atomically: true, encoding: .utf8)
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

//try! ExtensionDeclSyntax(
//  """
//  extension Keyword
//  """
//) {
//  try! VariableDeclSyntax(
//    """
//    /// Whether the token kind is switched from being an identifier to being a keyword in the lexer.
//    /// This is true for keywords that used to be considered non-contextual.
//    var isLexerClassified: Bool
//    """
//  ) {
//    try! SwitchExprSyntax("switch self") {
//      for keyword in Keyword.allCases {
//        if keyword.spec.isLexerClassified {
//          SwitchCaseSyntax("case .\(keyword.spec.varOrCaseName): return true")
//        }
//      }
//      SwitchCaseSyntax("default: return false")
//    }
//  }
//}
