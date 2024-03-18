import Foundation
import Models
import RealityCodable

extension RealityPlatform.visionOS.Entity {
  public var computedName: String {
    if let name = self.name, !name.isEmpty {
      return name
    } else {
      return "\(type(of: self))"
    }
  }

  //FIXME: figure out localized resource issue for `RealityCodable` accessibilityLabel
  public var _accessibilityLabel: String {
    "\(type(of: self)): \(name ?? "")"
  }
}
