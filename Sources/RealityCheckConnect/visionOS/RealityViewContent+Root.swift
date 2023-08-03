import Foundation
import RealityKit
import SwiftUI

@available(visionOS 1.0, *)
@available(iOS, unavailable)
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension RealityViewContent {
  var root: Entity? {
    guard let firstEntity = self.entities.first else { return nil }
    return climbToRoot(from: firstEntity)
  }

  private func climbToRoot(from entity: Entity) -> Entity {
    if let parent = entity.parent {
      return climbToRoot(from: parent)
    } else {
      return entity
    }
  }
}
