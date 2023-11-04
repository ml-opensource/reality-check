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

  mutating func run() throws {
    let url = URL(string: "file://\(input)")!.appending(path: "Components.json")
    let data = try Data(contentsOf: url)
    let _symbols: [_Symbol] = try JSONDecoder().decode([_Symbol].self, from: data)

    let file = SourceFileSyntax(
      leadingTrivia: "// This file was automatically generated and should not be edited."
    ) {
      DeclSyntax(
        """

        import Foundation
        import RealityKit

        """
      )

      DeclSyntax(
        """
        //MARK: - iOS

        extension RealityPlatform.iOS {
          public enum ComponentType: CaseIterable {
        """
      )

      for _symbol in _symbols {
        DeclSyntax(
          """
              case \(raw: _symbol.name.withFirstLetterLowercased())
          """
        )
      }

      DeclSyntax(
        """

          }
        }
        """
      )
    }

    print(file.formatted().description)
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
