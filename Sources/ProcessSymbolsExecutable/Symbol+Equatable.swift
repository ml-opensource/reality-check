import Foundation
import SymbolKit

extension SymbolGraph.Symbol: Equatable {
  public static func == (
    lhs: SymbolKit.SymbolGraph.Symbol,
    rhs: SymbolKit.SymbolGraph.Symbol
  ) -> Bool {
    lhs.identifier == rhs.identifier
  }
}

extension SymbolGraph.Symbol: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
    hasher.combine(absolutePath)
  }
}
