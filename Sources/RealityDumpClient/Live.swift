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
            componentsCount: loadedEntity.components.count
        )

        if let anchorEntity = loadedEntity as? AnchorEntity {
            identifiableEntities.append(
                .init(
                    id: anchorEntity.id,
                    anchorIdentifier: anchorEntity.anchorIdentifier,
                    name: anchorEntity.name,
                    type: .anchor,
                    state: state,
                    hierarhy: hierarhy,
                    components: components
                )
            )
        } else if let modelEntity = loadedEntity as? ModelEntity {
            identifiableEntities.append(
                .init(
                    id: modelEntity.id,
                    name: modelEntity.name,
                    type: .model,
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
