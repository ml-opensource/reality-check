import Foundation

extension RealityPlatform.iOS {
  public enum SessionEvent {
    case entitySelected(entityID: UInt64)
    case debugOptionsUpdated(options: _DebugOptions)
    case disconnectionRequested

    public init?(data: Data) {
      // Entity selection
      if let entitySelection = try? defaultDecoder.decode(EntitySelection.self, from: data) {
        self = .entitySelected(entityID: entitySelection.entityID)
        // selectedEntityID = entitySelection.entityID
        // await sendSelectedEntityMultipeerRawData()

      }
      // ARView Debug Options
      else if let debugOptions = try? defaultDecoder.decode(_DebugOptions.self, from: data) {
        self = .debugOptionsUpdated(options: debugOptions)
      }
      // Disconnection
      else if let _ = try? defaultDecoder.decode(Disconnection.self, from: data) {
        self = .disconnectionRequested
      }
      // Unkown
      else {
        return nil
      }
    }
  }
}

extension RealityPlatform.visionOS {
  public enum SessionEvent {
    case entitySelected(entityID: UInt64)
    case disconnectionRequested

    public init?(data: Data) {
      // Entity selection
      if let entitySelection = try? defaultDecoder.decode(EntitySelection.self, from: data) {
        self = .entitySelected(entityID: entitySelection.entityID)
      }
      // Disconnection
      else if let _ = try? defaultDecoder.decode(Disconnection.self, from: data) {
        self = .disconnectionRequested
      }
      // Unkown
      else {
        return nil
      }
    }
  }
}
