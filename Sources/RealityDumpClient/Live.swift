import CustomDump
import Dependencies
import Foundation
import RealityCodable
import RealityKit

extension RealityDump: DependencyKey {
  public static var liveValue: Self {
    return Self(
      identify: { loadedEntity in
        Parser.identify(loadedEntity)
      }
    )
  }
}

// MARK: -

enum Parser {
  static func identify(_ entity: Entity) -> _CodableEntity {
    identifyEntity(entity)
  }

  private static func identifyEntity(
    _ entity: Entity
  ) -> _CodableEntity {
    
    //FIXME: restore components identification
    // let state = CodableEntity.State(
    //   isEnabled: loadedEntity.isEnabled,
    //   isEnabledInHierarchy: loadedEntity.isEnabledInHierarchy,
    //   isActive: loadedEntity.isActive,
    //   isAnchored: loadedEntity.isAnchored
    // )
    // let hierarhy = CodableEntity.Hierarhy(
    //   children: loadedEntity.children.compactMap({ identify($0) }),
    //   parentID: loadedEntity.parent?.id
    // )
    // let components = CodableEntity.Components(
    //   components: identifyComponents(loadedEntity.components)
    // )
    // return CodableEntity(
    //   loadedEntity,
    //   state: state,
    //   hierarhy: hierarhy,
    //   components: components
    // )
    
    return entity.encoded
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
}
