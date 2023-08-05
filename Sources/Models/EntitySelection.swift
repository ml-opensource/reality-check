import Foundation

public struct EntitySelection: Codable {
  public let entityID: UInt64
  
  public init(
    _ entityID: UInt64
  ) {
    self.entityID = entityID
  }
}
