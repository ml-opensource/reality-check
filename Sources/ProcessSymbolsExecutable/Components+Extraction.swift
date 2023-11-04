import Foundation
import SymbolKit

// MARK: - Extract

func extractComponents(from symbolGraph: SymbolGraph) -> [SymbolGraph.Symbol] {
  let componentIdentifier = symbolGraph.symbols.values
    .first(where: { $0.names.title == "Component" })?
    .identifier.precise

  let conformingIdentifiers = symbolGraph.relationships
    .filter({ $0.kind == .conformsTo })
    .filter({ $0.target == componentIdentifier })
    .map(\.source)

  let components =
    conformingIdentifiers.compactMap { identifier in
      symbolGraph.symbols.values
        .filter({ $0.kind.identifier == .struct })
        .filter({ !$0.names.title.contains(".") })
        .first(where: { $0.identifier.precise == identifier })
    }

  return components
}

// MARK: - Create files

func createComponentsFile(from symbolGraph: SymbolGraph, at path: String) {
  let componentsSymbols = extractComponents(from: symbolGraph)
  let properties = extractProperties(from: componentsSymbols, in: symbolGraph)

  var _components: [_Symbol] = []

  for p in properties {
    _components.append(p)
  }
  
  let encoder = JSONEncoder()
  encoder.outputFormatting.insert(.sortedKeys)
  // encoder.outputFormatting.insert(.prettyPrinted)

  let encoded = try! encoder.encode(_components.sorted(by: { $0.name < $1.name }))
  FileManager.default.createFile(atPath: path.appending("/Components.json"), contents: encoded)
}

func createComponentsFile(from symbolGraphs: [SymbolGraph], at path: String) {
  var _components: Set<_Symbol> = []

  for symbolGraph in symbolGraphs {
    let symbols = extractComponents(from: symbolGraph)
    let properties = extractProperties(from: symbols, in: symbolGraph)

    for p in properties {
      _components.insert(p)
    }
  }

  let encoder = JSONEncoder()
  encoder.outputFormatting.insert(.sortedKeys)
  // encoder.outputFormatting.insert(.prettyPrinted)

  let encoded = try! encoder.encode(_components.sorted(by: { $0.name < $1.name }))
  FileManager.default.createFile(atPath: path, contents: encoded)
}
