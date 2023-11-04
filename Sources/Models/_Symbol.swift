import Foundation

public struct _Symbol: Codable, Hashable {
  public let name: String
  public let properties: [_Property]
  public let comment: String?

  public init(name: String, properties: [_Property], comment: String?) {
    self.name = name
    self.properties = properties
    self.comment = comment
  }

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

  public init(name: String, type: String?, complete: String?, comment: String?) {
    self.name = name
    self.type = type
    self.complete = complete
    self.comment = comment
  }
}
