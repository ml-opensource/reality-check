import Foundation
import Models
import RealityKit

//MARK: - iOS

extension RealityPlatform.iOS {
  /**
   Scene structure on iOS

   ```
                                  ┌─────────┐
                                  │ ARView  │
                                  └─────────┘
                                       │
                                ┌─────────────┐
                                │    Scene    │
                                └─────────────┘
                         ┌─────────────┴─────────────┐
               ┌───────────────────┐       ┌───────────────────┐
               │   Anchor Entity   │       │   Anchor Entity   │
               └───────────────────┘       └───────────────────┘
                ┌────────┴───────┐                   │
           ┌─────────┐      ┌─────────┐         ┌─────────┐
           │ Entity  │      │ Entity  │         │ Entity  │
           └─────────┘      └─────────┘         └─────────┘
        ┌───────┴──────┐
   ┌─────────┐    ┌─────────┐
   │ Entity  │    │ Entity  │
   └─────────┘    └─────────┘
   ```
  */
  public struct Scene: Codable, Equatable {
    public let anchors: [RealityPlatform.iOS.AnchorEntity]

    public init(
      anchors: [RealityPlatform.iOS.AnchorEntity]
    ) {
      self.anchors = anchors
    }
  }
}

extension RealityPlatform.iOS.Scene {

  /// Performs a depth-first search in a tree-like structure represented by `Entity`.
  ///
  /// - Parameters:
  ///   - root: The root node of the tree.
  ///   - targetID: The target ID to search for.
  /// - Returns: The `Entity` with the matching ID, or `nil` if not found.
  ///
  /// - Complexity: O(n), where n is the number of nodes in the tree.
  ///
  /// - Note: This method assumes that each node has a unique ID.
  ///
  // public func findEntity(root: Entity, targetID: UInt64) -> Entity? {
  //   if root.id == targetID {
  //     return root
  //   }
  //
  //   for child in root.children {
  //     if let foundNode = findEntity(root: child, targetID: targetID) {
  //       return foundNode
  //     }
  //   }

  //   return nil
  // }

  public static func findEntity(
    id targetID: RealityPlatform.iOS.Entity.ID,
    root: RealityPlatform.iOS.Entity
  ) -> RealityPlatform.iOS.Entity? {
    if targetID == root.id {
      return root
    }

    for child in root.children.map(\.value) {
      if let foundNode = findEntity(id: targetID, root: child) {
        return foundNode
      }
    }

    return nil
  }
}

//extension RealityPlatform.visionOS.Scene {
//  //TODO: make generic
//  public static func findEntity(
//    id targetID: RealityPlatform.visionOS.Entity.ID,
//    root: RealityPlatform.visionOS.Entity
//  ) -> RealityPlatform.visionOS.Entity? {
//    if targetID == root.id {
//      return root
//    }
//
//    for child in root.children.map(\.value) {
//      if let foundNode = findEntity(id: targetID, root: child) {
//        return foundNode
//      }
//    }
//
//    return nil
//  }
//}

//MARK: - macOS

extension RealityPlatform.macOS {

  public struct Scene: Codable, Equatable {
    public let anchors: [RealityPlatform.macOS.AnchorEntity]

    public init(
      anchors: [RealityPlatform.macOS.AnchorEntity]
    ) {
      self.anchors = anchors
    }
  }
}

//MARK: - visionOS

extension RealityPlatform.visionOS {
  /**
   Scene structure on visionOS

   ```
                                ┌─────────────┐
                                │    Scene    │
                                └─────────────┘
                                       │
                         ┌─────────────┴─────────────┐
                ┌────────┴───────┐                   │
           ┌─────────┐      ┌─────────┐         ┌─────────┐
           │ Entity  │      │ Entity  │         │ Entity  │
           └─────────┘      └─────────┘         └─────────┘
        ┌───────┴──────┐
   ┌─────────┐    ┌─────────┐
   │ Entity  │    │ Entity  │
   └─────────┘    └─────────┘
   ```
  */
  public struct Scene: Codable, Equatable {
    public let children: [RealityPlatform.visionOS.EntityType]

    public init(
      children: [RealityPlatform.visionOS.EntityType]
    ) {
      self.children = children
    }
  }
}

extension RealityPlatform.visionOS.Scene {
  //TODO: make generic
  public static func findEntity(
    id targetID: RealityPlatform.visionOS.Entity.ID,
    root: RealityPlatform.visionOS.Entity
  ) -> RealityPlatform.visionOS.Entity? {
    if targetID == root.id {
      return root
    }

    for child in root.children.map(\.value) {
      if let foundNode = findEntity(id: targetID, root: child) {
        return foundNode
      }
    }

    return nil
  }
}
