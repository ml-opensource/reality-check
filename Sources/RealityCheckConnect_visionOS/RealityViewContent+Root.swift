import Foundation
import RealityKit
import SwiftUI

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
