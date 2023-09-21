import CustomDump
import Dependencies
import Foundation
import RealityCodable
import RealityKit

extension RealityDump: DependencyKey {
  public static var liveValue: Self {
    return Self(
      //      dump: { (loadedEntity, printing) in
      //        //TODO: honor printing parameter
      //        String(customDumping: loadedEntity)
      //      },
      identify: { (loadedEntity, detail) in
        Parser.identify(loadedEntity)
      }
    )
  }
}

// MARK: -

enum Parser {
  static func identify(_ loadedEntity: Entity, detail: Int = 1) -> CodableEntity {
    identifyEntity(loadedEntity, detail: detail, nesting: 1)
  }

  private static func identifyComponents(
    _ components: Entity.ComponentSet
  ) -> [CodableComponent] {
    var CodableComponents: [CodableComponent] = []
    for componentType in CodableComponent.ComponentType.allCases {
      if let component = components[componentType.rawValue] {
        CodableComponents.append(CodableComponent(component))
      }
    }
    return CodableComponents
  }

  private static func identifyEntity(
    _ loadedEntity: Entity,
    detail: Int,
    nesting: Int
  ) -> CodableEntity {
    let state = CodableEntity.State(
      isEnabled: loadedEntity.isEnabled,
      isEnabledInHierarchy: loadedEntity.isEnabledInHierarchy,
      isActive: loadedEntity.isActive,
      isAnchored: loadedEntity.isAnchored
    )
    let hierarhy = CodableEntity.Hierarhy(
      children: loadedEntity.children.compactMap({ identify($0) }),
      parentID: loadedEntity.parent?.id
    )
    let components = CodableEntity.Components(
      components: identifyComponents(loadedEntity.components)
    )
    return CodableEntity(
      loadedEntity,
      state: state,
      hierarhy: hierarhy,
      components: components
    )
  }
}
