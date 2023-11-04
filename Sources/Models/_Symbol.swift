import Foundation

public struct _Symbol: Codable, Hashable {
  public let name: String
  public let properties: [_Property]
  public let comment: String?

  public func hash(into hasher: inout Hasher) {
    hasher.combine(name)
    hasher.combine(properties)
  }

  public static func == (lhs: _Symbol, rhs: _Symbol) -> Bool {
    lhs.name == rhs.name
  }
}

public struct _Property: Codable, Hashable {
  public let name: String
  public let type: String?
  public let complete: String?
  public let comment: String?
}
