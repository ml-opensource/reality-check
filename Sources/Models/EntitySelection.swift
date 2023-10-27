import Foundation

//TODO: convert to command. i.e. .send(entitySelection(UInt64))
public struct EntitySelection: Codable {
  public let entityID: UInt64
  
  public init(
    _ entityID: UInt64
  ) {
    self.entityID = entityID
  }
}
