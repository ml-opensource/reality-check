// This file was automatically generated and should not be edited.

import Foundation
import Models
import RealityKit

//MARK: - iOS


#if os(iOS)
extension RealityKit.Entity {
  public var encoded: RealityPlatform.iOS.EntityType {
    switch "\(type(of: self))" {
      case "AnchorEntity":
        return .anchorEntity(.init(rawValue: self))
      case "BodyTrackedEntity":
        return .bodyTrackedEntity(.init(rawValue: self))
      case "DirectionalLight":
        return .directionalLight(.init(rawValue: self))
      case "Entity":
        return .entity(.init(self))
      case "ModelEntity":
        return .modelEntity(.init(rawValue: self))
      case "PerspectiveCamera":
        return .perspectiveCamera(.init(rawValue: self))
      case "PointLight":
        return .pointLight(.init(rawValue: self))
      case "SpotLight":
        return .spotLight(.init(rawValue: self))
      case "TriggerVolume":
        return .triggerVolume(.init(rawValue: self))
      default:
        return .entity(.init(self))
    }
  }
}
#endif

//MARK: - macOS


#if os(macOS)
extension RealityKit.Entity {
  public var encoded: RealityPlatform.macOS.EntityType {
    switch "\(type(of: self))" {
      case "AnchorEntity":
        return .anchorEntity(.init(rawValue: self))
      case "DirectionalLight":
        return .directionalLight(.init(rawValue: self))
      case "Entity":
        return .entity(.init(self))
      case "ModelEntity":
        return .modelEntity(.init(rawValue: self))
      case "PerspectiveCamera":
        return .perspectiveCamera(.init(rawValue: self))
      case "PointLight":
        return .pointLight(.init(rawValue: self))
      case "SpotLight":
        return .spotLight(.init(rawValue: self))
      case "TriggerVolume":
        return .triggerVolume(.init(rawValue: self))
      default:
        return .entity(.init(self))
    }
  }
}
#endif

//MARK: - visionOS


#if os(visionOS)
extension RealityKit.Entity {
  public var encoded: RealityPlatform.visionOS.EntityType {
    switch "\(type(of: self))" {
      case "AnchorEntity":
        return .anchorEntity(.init(rawValue: self))
      case "Entity":
        return .entity(.init(self))
      case "ModelEntity":
        return .modelEntity(.init(rawValue: self))
      case "PerspectiveCamera":
        return .perspectiveCamera(.init(rawValue: self))
      case "TriggerVolume":
        return .triggerVolume(.init(rawValue: self))
      default:
        return .entity(.init(self))
    }
  }
}
#endif
