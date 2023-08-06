import CustomDump
import Dependencies
import Foundation
import Models
import RealityKit

extension RealityDump: DependencyKey {
  public static var liveValue: Self {
    return Self(
      raw: { (loadedEntity, printing, detail, org) in
        // dumpRealityEntity(loadedEntity, printing: printing)
        String(customDumping: loadedEntity)
      },
      identify: { (loadedEntity, detail) in
        Parser.identify(loadedEntity)
      }
    )
  }
}

// MARK: -

enum Parser {
  static func identify(_ loadedEntity: Entity, detail: Int = 1) -> IdentifiableEntity {
    identifyEntity(loadedEntity, detail: detail, nesting: 1)
  }

  private static func identifyComponents(
    _ components: Entity.ComponentSet
  ) -> [IdentifiableComponent] {
    var identifiableComponents: [IdentifiableComponent] = []
    for componentType in IdentifiableComponent.ComponentType.allCases {
      if let component = components[componentType.rawValue] {
        identifiableComponents.append(IdentifiableComponent(component))
      }
    }
    return identifiableComponents
  }

  private static func identifyEntity(
    _ loadedEntity: Entity,
    detail: Int,
    nesting: Int
  ) -> IdentifiableEntity {
    let state = IdentifiableEntity.State(
      isEnabled: loadedEntity.isEnabled,
      isEnabledInHierarchy: loadedEntity.isEnabledInHierarchy,
      isActive: loadedEntity.isActive,
      isAnchored: loadedEntity.isAnchored
    )
    let hierarhy = IdentifiableEntity.Hierarhy(
      children: loadedEntity.children.compactMap({ identify($0) }),
      parentID: loadedEntity.parent?.id
    )
    let components = IdentifiableEntity.Components(
      components: identifyComponents(loadedEntity.components)
    )
    return IdentifiableEntity(
      loadedEntity,
      state: state,
      hierarhy: hierarhy,
      components: components
    )
  }
}

extension RealityKit.Entity: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(
      self,
      children: [
        /// Identity
        "scene": self.scene,
        "name": self.name,
        "id": self.id,
        /// State
        "isEnabled": self.isEnabled,
        "isEnabledInHierarchy": self.isEnabledInHierarchy,
        "isActive": self.isActive,
        "isAnchored": self.isAnchored,
        /// Hierarchy
        "parentID": self.parent?.id,
        "children": self.children.map({ $0 }),
        ///Components
        "components": self.components,
        /// Synchronization
        //TODO: "synchronization": self.synchronization,
        "isOwner": self.isOwner,
        ///Nearest Anchor
        //TODO: "anchor": self.anchor,
        ///Animations
        //TODO: "availableAnimations": self.availableAnimations,
        ///Animating an Entity
        //TODO: "defaultAnimationClock": self.defaultAnimationClock,
        //TODO: "bindableValues": self.bindableValues,
        //TODO: "parameters": self.parameters,
        ///Animating and Controlling Characters
        //TODO: "characterController": self.characterController,
        //TODO: "characterControllerState": self.characterControllerState,
        ///Accessibility
        "isAccessibilityElement": self.isAccessibilityElement,

          //TODO: Instance Properties
      ],
      displayStyle: .struct
    )
  }
}
