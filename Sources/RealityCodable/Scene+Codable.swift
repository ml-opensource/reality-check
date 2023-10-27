import Foundation
import Models
import RealityKit

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
