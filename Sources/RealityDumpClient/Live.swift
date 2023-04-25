import Dependencies
import Foundation
import Models
import RealityKit

extension RealityDump: DependencyKey {
    public static var liveValue: Self {
        return Self(
            raw: { (loadedEntity, printing, detail, org) in
                dumpRealityEntity(loadedEntity, printing: printing, detail: detail, org: org)
            },
            identify: { (loadedEntity, detail) in
                Dumper.dump(loadedEntity)
            }
        )
    }
}

// MARK: -

enum Dumper {
    static func dump(_ loadedEntity: Entity, detail: Int = 1) -> [IdentifiableEntity] {
        identifyEntities(loadedEntity, detail: detail, nesting: 1)
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

        print(identifiableComponents.map(\.componentType.rawValue))
        return identifiableComponents
    }

    private static func identifyEntities(
        _ loadedEntity: Entity, detail: Int, nesting: Int
    ) -> [IdentifiableEntity] {

        var identifiableEntities: [IdentifiableEntity] = []

        let state = IdentifiableEntity.State(
            isEnabled: loadedEntity.isEnabled,
            isEnabledInHierarchy: loadedEntity.isEnabledInHierarchy,
            isActive: loadedEntity.isActive,
            isAnchored: loadedEntity.isAnchored
        )
        let hierarhy = IdentifiableEntity.Hierarhy(
            children: loadedEntity.children.flatMap({ dump($0) }),
            hasParent: !(loadedEntity.parent == nil)
        )
        let components = IdentifiableEntity.Components(
            components: identifyComponents(loadedEntity.components)
        )

        if let loadedEntity = loadedEntity as? AnchorEntity {
            identifiableEntities.append(
                .init(
                    id: loadedEntity.id,
                    anchorIdentifier: loadedEntity.anchorIdentifier,
                    name: loadedEntity.name,
                    type: .anchor,
                    state: state,
                    hierarhy: hierarhy,
                    components: components
                )
            )
        } else if let loadedEntity = loadedEntity as? ModelEntity {
            identifiableEntities.append(
                .init(
                    id: loadedEntity.id,
                    name: loadedEntity.name,
                    type: .model,
                    state: state,
                    hierarhy: hierarhy,
                    components: components
                )
            )
        } else if let loadedEntity = loadedEntity as? DirectionalLight {
            identifiableEntities.append(
                .init(
                    id: loadedEntity.id,
                    name: loadedEntity.name,
                    type: .directionalLight,
                    state: state,
                    hierarhy: hierarhy,
                    components: components
                )
            )
        } else if let loadedEntity = loadedEntity as? PointLight {
            identifiableEntities.append(
                .init(
                    id: loadedEntity.id,
                    name: loadedEntity.name,
                    type: .pointLight,
                    state: state,
                    hierarhy: hierarhy,
                    components: components
                )
            )
        } else if let loadedEntity = loadedEntity as? SpotLight {
            identifiableEntities.append(
                .init(
                    id: loadedEntity.id,
                    name: loadedEntity.name,
                    type: .spotLight,
                    state: state,
                    hierarhy: hierarhy,
                    components: components
                )
            )
        } else if let loadedEntity = loadedEntity as? PerspectiveCamera {
            identifiableEntities.append(
                .init(
                    id: loadedEntity.id,
                    name: loadedEntity.name,
                    type: .perspectiveCamera,
                    state: state,
                    hierarhy: hierarhy,
                    components: components
                )
            )
        } else if let loadedEntity = loadedEntity as? TriggerVolume {
            identifiableEntities.append(
                .init(
                    id: loadedEntity.id,
                    name: loadedEntity.name,
                    type: .triggerVolume,
                    state: state,
                    hierarhy: hierarhy,
                    components: components
                )
            )
        } else {
            identifiableEntities.append(
                .init(
                    id: loadedEntity.id,
                    name: loadedEntity.name,
                    type: .entity,
                    state: state,
                    hierarhy: hierarhy,
                    components: components
                )
            )
        }

        return identifiableEntities
    }
}
