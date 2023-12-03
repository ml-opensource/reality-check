import Foundation
import Models
import RealityCodable

extension RealityPlatform.iOS.Entity {
  public var computedName: String {
    if let name = self.name, !name.isEmpty {
      return name
    } else {
      return "\(type(of: self))"
    }
  }
}

extension RealityPlatform.visionOS.Entity {
  public var computedName: String {
    if let name = self.name, !name.isEmpty {
      return name
    } else {
      return "\(type(of: self))"
    }
  }
}
