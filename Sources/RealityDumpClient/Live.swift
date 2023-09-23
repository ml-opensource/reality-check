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
  static func identify(_ entity: Entity) -> CodableEntity {
    identifyEntity(entity)
  }

  private static func identifyEntity(
    _ entity: Entity
  ) -> CodableEntity {

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

//  private static func identifyComponents(
//    _ components: Entity.ComponentSet
//  ) -> [CodableComponent] {
//    var codableComponents: [CodableComponent] = []
//    for componentType in ComponentType.allCases {
//      if let component = components[componentType.type] {
//        codableComponents.append(CodableComponent(component))
//      }
//    }
//    return codableComponents
//  }
}
