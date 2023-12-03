import Foundation
import Models
import RealityCodable

extension RealityPlatform.iOS.Entity {
  public var systemImage: String {
    switch "\(type(of: self))" {
      case "AnchorEntity":
        "arrow.down.to.line"

      case "BodyTrackedEntity":
        "figure"

      case "DirectionalLight":
        "sun.max"

      case "Entity":
        "move.3d"

      case "ModelEntity":
        "cube"

      case "PerspectiveCamera":
        "camera"

      case "PointLight":
        "lightbulb.min"

      case "SpotLight":
        "lamp.desk"

      case "TriggerVolume":
        "cube.transparent"

      default:
        "move.3d"
    }
  }
}

extension RealityPlatform.visionOS.Entity {
  public var systemImage: String {
    switch "\(type(of: self))" {
      case "AnchorEntity":
        "arrow.down.to.line"

      case "Entity":
        "move.3d"

      case "ModelEntity":
        "cube"

      case "PerspectiveCamera":
        "camera"

      case "TriggerVolume":
        "cube.transparent"

      default:
        "move.3d"
    }
  }
}
