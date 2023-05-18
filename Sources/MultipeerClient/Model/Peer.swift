import Foundation
import MultipeerConnectivity

/// A value type wrapper for `MCPeerID`. This type is necessary so that we can do equality checks
/// and write tests against its values.
@dynamicMemberLookup
public struct Peer: Identifiable {
  public let rawValue: MCPeerID
  public var id: MCPeerID { self.rawValue }

  public init(displayName: String) {
    self.rawValue = MCPeerID(displayName: displayName)
  }

  public init(rawValue: MCPeerID) {
    self.rawValue = rawValue
  }

  public subscript<T>(dynamicMember keyPath: KeyPath<MCPeerID, T>) -> T {
    self.rawValue[keyPath: keyPath]
  }
}

extension Peer: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(self.displayName)
  }
}
