import Foundation
import RealityKit

/// Performs a depth-first search in a tree-like structure represented by `RealityKit.Entity`.
///
/// - Parameters:
///   - id: The target ID to search for.
/// - Returns: The `RealityKit.Entity` with the matching ID, or `nil` if not found.
///
/// - Complexity: O(n), where n is the number of nodes in the tree.
///
/// - Note: This method assumes that each node has a unique ID.

extension RealityKit.Entity {
  public func findEntity(id targetID: UInt64) -> RealityKit.Entity? {
    if self.id == targetID {
      return self
    }

    for child in self.children {
      if let foundNode = child.findEntity(id: targetID) {
        return foundNode
      }
    }

    return nil
  }
}
