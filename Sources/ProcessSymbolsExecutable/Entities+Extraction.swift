import Foundation
import Models
import SymbolKit

// MARK: - Extract

private func extractEntitiesSymbols(from symbolGraph: SymbolGraph) -> [SymbolGraph.Symbol] {
  let entity = symbolGraph.symbols.values.first(where: { $0.names.title == "Entity" })!

  let subclassesIdentifiers = symbolGraph.relationships
    .filter({ $0.kind == .inheritsFrom })
    .filter({ $0.target == entity.identifier.precise })
    .map(\.source)

  let subclasses = subclassesIdentifiers.compactMap { identifier in
    symbolGraph.symbols.values
      .filter({ $0.kind.identifier == .class })
      .first(where: { $0.identifier.precise == identifier })
  }

  return subclasses + [entity]
}

func extractEntities(from symbolGraphs: [SymbolGraph]) -> [SymbolGraph.Symbol] {
  var entities: Set<SymbolGraph.Symbol> = []

  for symbolGraph in symbolGraphs {
    let entity = symbolGraph.symbols.values.first(where: { $0.names.title == "Entity" })!

    let subclassesIdentifiers = symbolGraph.relationships
      .filter({ $0.kind == .inheritsFrom })
      .filter({ $0.target == entity.identifier.precise })
      .map(\.source)

    let subclasses = subclassesIdentifiers.compactMap { identifier in
      symbolGraph.symbols.values
        .filter({ $0.kind.identifier == .class })
        .first(where: { $0.identifier.precise == identifier })
    }

    // return subclasses + [entity]
    entities.formUnion(subclasses)
  }

  return Array(entities)
}

// MARK: - Create files

func createEntitiesFile(from symbolGraph: SymbolGraph, at path: String) {
  let symbols = extractEntitiesSymbols(from: symbolGraph)
  let properties = extractProperties(from: symbols, in: symbolGraph)

  var _entities: [_Symbol] = []

  for p in properties {
    _entities.append(p)
  }

  let encoder = JSONEncoder()
  encoder.outputFormatting.insert(.sortedKeys)
  encoder.outputFormatting.insert(.prettyPrinted)

  let encoded = try! encoder.encode(_entities.sorted(by: { $0.name < $1.name }))
  FileManager.default.createFile(atPath: path.appending("/Entities.json"), contents: encoded)
}

func createEntitiesFile(from symbolGraphs: [SymbolGraph], at path: String) {
  var _entities: Set<_Symbol> = []

  for symbolGraph in symbolGraphs {
    let symbols = extractEntitiesSymbols(from: symbolGraph)
    let properties = extractProperties(from: symbols, in: symbolGraph)

    for p in properties {
      _entities.insert(p)
    }
  }

  let encoder = JSONEncoder()
  encoder.outputFormatting.insert(.sortedKeys)
  encoder.outputFormatting.insert(.prettyPrinted)

  let encoded = try! encoder.encode(_entities.sorted(by: { $0.name < $1.name }))
  FileManager.default.createFile(atPath: path, contents: encoded)
}
