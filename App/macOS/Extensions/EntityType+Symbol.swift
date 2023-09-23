import Foundation
import RealityKit

#if os(iOS)

extension EntityType {
  public var symbol: String {
    switch self {
    case .entity:
      return "Entity"
    case .modelEntity:
      return "ModelEntity"
    case .perspectiveCamera:
      return "PerspectiveCamera"
    }
  }
}

#elseif os(macOS)

extension EntityType {
  public var symbol: String {
    switch self {
    case .entity:
      return "Entity"
    case .modelEntity:
      return "ModelEntity"
    case .perspectiveCamera:
      return "PerspectiveCamera"
    }
  }
}

#elseif os(visionOS)

extension EntityType {
  public var symbol: String {
    switch self {
    case .anchorEntity:
      return "AnchorEntity"
    case .entity:
      return "Entity"
    case .modelEntity:
      return "ModelEntity"
    case .perspectiveCamera:
      return "PerspectiveCamera"
    case .triggerVolume:
      return "TriggerVolume"
    }
  }
}

#endif
