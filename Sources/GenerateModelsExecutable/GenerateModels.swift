import ArgumentParser
import SwiftSyntax
import SwiftSyntaxBuilder

@main
struct GenerateModels: ParsableCommand {
  @Argument(help: "Input file path.")
  var input: String
  
  mutating func run() throws {
    let properties = [
      "firstName": "String",
      "lastName": "String",
      "age": "Int",
    ]

    let source = SourceFileSyntax {
      StructDeclSyntax(name: "Person") {
        for (propertyName, propertyType) in properties {
          DeclSyntax("var \(raw: propertyName): \(raw: propertyType)")

          DeclSyntax(
            """
            func with\(raw: propertyName.withFirstLetterUppercased())(_ \(raw: propertyName): \(raw: propertyType)) -> Person {
              var result = self
              result.\(raw: propertyName) = \(raw: propertyName)
              return result
            }
            """
          )
        }
      }
    }

    print(source.formatted().description)
  }
}

/// This example will print the following code:
///
/// ```
/// struct Person {
///     var lastName: String
///     func withLastName(_ lastName: String) -> Person {
///         var result = self
///         result.lastName = lastName
///         return result
///     }
///     var firstName: String
///     func withFirstName(_ firstName: String) -> Person {
///         var result = self
///         result.firstName = firstName
///         return result
///     }
///     var age: Int
///     func withAge(_ age: Int) -> Person {
///         var result = self
///         result.age = age
///         return result
///     }
/// }
/// ```
///

extension String {
  func withFirstLetterUppercased() -> String {
    if let firstLetter = self.first {
      return firstLetter.uppercased() + self.dropFirst()
    } else {
      return self
    }
  }
}
