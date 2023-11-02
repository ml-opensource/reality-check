import Foundation
import SymbolKit

struct _Property: Codable, Hashable {
  let name: String
  let type: String?
  let complete: String?
  let comment: String?
}

struct _Properties: Codable, Hashable {
  let name: String
  let properties: [_Property]
  let comment: String?

  func hash(into hasher: inout Hasher) {
    hasher.combine(name)
    hasher.combine(properties)
  }

  static func == (lhs: _Properties, rhs: _Properties) -> Bool {
    lhs.name == rhs.name
  }
}

//TODO: consider moving to an extension of SymbolGraph
func extractProperties(
  from symbols: [SymbolGraph.Symbol],
  in symbolGraph: SymbolGraph
) -> [_Properties] {

  var _properties: [_Properties] = []
  for symbol in symbols {

    var symbol_properties: [_Property] = []

    let properties = symbolGraph.symbols.values
      .filter({ $0.pathComponents.count == 2 })
      .filter({ $0.pathComponents.contains(symbol.names.title) })
      .filter({ $0.kind.identifier == .property })

    for property in properties {
      let name = property.names.title
      let type = property.names.typeSpelling
      let complete = property.declarationFragments?.map(\.spelling).joined()
      let comment = property.docComment?.lines.map(\.text).joined(separator: " ")

      symbol_properties.append(
        .init(
          name: name,
          type: type,
          complete: complete,
          comment: comment
        )
      )
    }

    _properties.append(
      .init(
        name: symbol.names.title,
        properties: symbol_properties,
        comment: symbol.docComment?.lines.map(\.text).joined(separator: " ")
      )
    )
  }

  return _properties
}

extension SymbolGraph.Symbol.Names {
  var typeSpelling: String? {
    guard let inputString = self.subHeading?.map(\.spelling).reduce("", +) else { return nil }
    let startChar: Character = ":"
    let endChar: Character = "?"
    if let startIndex = inputString.firstIndex(of: startChar) {
      let endIndex = inputString.firstIndex(of: endChar) ?? inputString.endIndex
      let substring = inputString[inputString.index(after: startIndex)..<endIndex]
      return String(substring.trimmingCharacters(in: .whitespaces))
    } else {
      return nil
    }
  }
}
