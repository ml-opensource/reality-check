import Foundation
import Models
import RealityCodable

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
