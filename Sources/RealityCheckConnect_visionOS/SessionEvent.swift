import Foundation
import Models

enum SessionEvent {
  case entitySelected(entityID: UInt64)
  case disconnectionRequested

  init?(data: Data) {
    /// Entity selection
    if let entitySelection = try? defaultDecoder.decode(EntitySelection.self, from: data) {
      self = .entitySelected(entityID: entitySelection.entityID)
    }/// Disconnection
    else if let request = try? defaultDecoder.decode(Disconnection.self, from: data) {
      self = .disconnectionRequested
    }/// Unkown
    else {
      return nil
    }
  }
}
