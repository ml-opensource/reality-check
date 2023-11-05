import ArgumentParser
import CustomDump
import Foundation
import Models
import SwiftSyntax
import SwiftSyntaxBuilder

@available(macOS 13.0, *)
struct GenerateComponentCodable: ParsableCommand {
  static var configuration = CommandConfiguration(
    commandName: "component-codable"
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
      try ImportDeclSyntax("import Foundation")
      try ImportDeclSyntax("import Models")
      try ImportDeclSyntax("import RealityKit")

      //MARK: - Component
      //FIXME: consider align structure with `Entity/EntityType`

      try ExtensionDeclSyntax(
        """
        extension RealityPlatform.\(raw: source.lastPathComponent)
        """
      ) {
        try EnumDeclSyntax(
          """
          public enum Component: Codable, Hashable
          """
        ) {
          for symbol in _symbols {
            try EnumCaseDeclSyntax(
              """
              case \(raw: symbol.name.withFirstLetterLowercased())(\(raw: symbol.name))
              """
            )
          }
        }
      }

      //MARK: - Description

      try ExtensionDeclSyntax(
        """
        extension RealityPlatform.\(raw: source.lastPathComponent).Component: CustomStringConvertible
        """
      ) {
        try VariableDeclSyntax("public var description: String") {
          try SwitchExprSyntax("switch self") {
            for symbol in _symbols {
              SwitchCaseSyntax(
                """
                case .\(raw: symbol.name.withFirstLetterLowercased()):
                  return "\(raw: symbol.name)"
                """
              )
            }
          }
        }
      }

      //MARK: - Comment

      try ExtensionDeclSyntax(
        """
        extension RealityPlatform.\(raw: source.lastPathComponent).Component
        """
      ) {
        try VariableDeclSyntax("public var comment: String?") {
          try SwitchExprSyntax("switch self") {
            for symbol in _symbols {
              SwitchCaseSyntax(
                """
                case .\(raw: symbol.name.withFirstLetterLowercased())(let value):
                  return value.comment
                """
              )
            }
          }
        }
      }

      //MARK: - Reflected Description

      try ExtensionDeclSyntax(
        """
        extension RealityPlatform.\(raw: source.lastPathComponent).Component
        """
      ) {
        try VariableDeclSyntax("public var reflectedDescription: String?") {
          try SwitchExprSyntax("switch self") {
            for symbol in _symbols {
              SwitchCaseSyntax(
                """
                case .\(raw: symbol.name.withFirstLetterLowercased())(let value):
                  return value.reflectedDescription
                """
              )
            }
          }
        }
      }

      //MARK: - Init

      try ExtensionDeclSyntax(
        """
        //MARK: \(raw: source.lastPathComponent)

        extension RealityPlatform.\(raw: source.lastPathComponent)
        """
      ) {
        for symbol in _symbols {
          try StructDeclSyntax("public struct \(raw: symbol.name): Codable, Hashable") {
            try VariableDeclSyntax("public var comment: String?")
            try VariableDeclSyntax("public var reflectedDescription: String")

            DeclSyntax("#if os(\(raw: source.lastPathComponent))")

            try InitializerDeclSyntax("init(rawValue component: RealityKit.\(raw: symbol.name))") {
              for property in symbol.properties {
                DeclReferenceExprSyntax(
                  baseName:
                    """
                    //TODO: self.\(raw: property.name) = component.\(raw: property.name)
                    """
                )
              }
              if let comment = symbol.comment {
                DeclReferenceExprSyntax(
                  baseName:
                    """
                    self.comment =
                      \"""
                      \(raw: comment)
                      \"""
                    """
                )
              }
              DeclReferenceExprSyntax(
                baseName:
                  """
                  self.reflectedDescription = String(customDumping: component)
                  """
              )
            }
            .with(\.trailingTrivia, .newline)

            DeclSyntax("#endif")
              .with(\.trailingTrivia, .carriageReturnLineFeed)
          }
        }
      }

      //MARK: -

      DeclSyntax("#if os(\(raw: source.lastPathComponent))")

      try ExtensionDeclSyntax(
        """
        extension RealityPlatform.\(raw: source.lastPathComponent).ComponentType
        """
      ) {
        try FunctionDeclSyntax(
          """
          func makeCodable(from component: RealityKit.Component) -> RealityPlatform.\(raw: source.lastPathComponent).Component
          """
        ) {
          try SwitchExprSyntax("switch self") {
            for symbol in _symbols {
              SwitchCaseSyntax(
                """
                case .\(raw: symbol.name.withFirstLetterLowercased()):
                  return .\(raw: symbol.name.withFirstLetterLowercased())(.init(rawValue: component as! \(raw: symbol.name)))
                """
              )
            }
          }
        }
      }
      .with(\.trailingTrivia, .newline)

      DeclSyntax("#endif")
        .with(\.trailingTrivia, .carriageReturnLineFeed)
    }

    //MARK: Save
    let fileURL = destination.appending(path: "ComponentCodable_\(source.lastPathComponent).swift")
    try file.formatted().description.write(to: fileURL, atomically: true, encoding: .utf8)
  }
}
