import Foundation
import SymbolKit

//TODO: consider moving to an extension of SymbolGraph
func extractProperties(
  from symbols: [SymbolGraph.Symbol],
  in symbolGraph: SymbolGraph
) -> [_Symbol] {

  var _symbols: [_Symbol] = []
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

    _symbols.append(
      .init(
        name: symbol.names.title,
        properties: symbol_properties,
        comment: symbol.docComment?.lines.map(\.text).joined(separator: " ")
      )
    )
  }

  return _symbols
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
