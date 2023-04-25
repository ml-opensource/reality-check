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
        entityToIdentifiableEntity(loadedEntity, detail: detail, nesting: 1)
    }

    private static func entityToIdentifiableEntity(
        _ loadedEntity: Entity, detail: Int, nesting: Int
    )
        -> [IdentifiableEntity]
    {
        var identifiableEntities: [IdentifiableEntity] = []

        if let anchorEntity = loadedEntity as? AnchorEntity {
            let children = anchorEntity.children.flatMap { dump($0) }
            identifiableEntities.append(
                .init(
                    id: anchorEntity.id,
                    anchorIdentifier: anchorEntity.anchorIdentifier,
                    name: anchorEntity.name,
                    type: .anchor,
                    children: children.isEmpty ? nil : children,
                    state: .init(
                        isEnabled: anchorEntity.isEnabled,
                        isEnabledInHierarchy: anchorEntity.isEnabledInHierarchy,
                        isActive: anchorEntity.isActive,
                        isAnchored: anchorEntity.isAnchored
                    ),
                    hierarhy: .init(
                        hasParent: !(anchorEntity.parent == nil),
                        childrenCount: anchorEntity.children.count
                    ),
                    components: .init(
                        componentsCount: anchorEntity.components.count
                    )
                )

            )
        } else if let modelEntity = loadedEntity as? ModelEntity {
            let children = modelEntity.children.flatMap { dump($0) }
            identifiableEntities.append(
                .init(
                    id: modelEntity.id,
                    name: modelEntity.name,
                    type: .model,
                    children: children.isEmpty ? nil : children,
                    state: .init(
                        isEnabled: modelEntity.isEnabled,
                        isEnabledInHierarchy: modelEntity.isEnabledInHierarchy,
                        isActive: modelEntity.isActive,
                        isAnchored: modelEntity.isAnchored
                    ),
                    hierarhy: .init(
                        hasParent: !(modelEntity.parent == nil),
                        childrenCount: modelEntity.children.count
                    ),
                    components: .init(
                        componentsCount: modelEntity.components.count
                    )
                )
            )
        } else {
            let children = loadedEntity.children.flatMap { dump($0) }
            identifiableEntities.append(
                .init(
                    id: loadedEntity.id,
                    name: loadedEntity.name,
                    type: .entity,
                    children: children.isEmpty ? nil : children,
                    state: .init(
                        isEnabled: loadedEntity.isEnabled,
                        isEnabledInHierarchy: loadedEntity.isEnabledInHierarchy,
                        isActive: loadedEntity.isActive,
                        isAnchored: loadedEntity.isAnchored
                    ),
                    hierarhy: .init(
                        hasParent: !(loadedEntity.parent == nil),
                        childrenCount: loadedEntity.children.count
                    ),
                    components: .init(
                        componentsCount: loadedEntity.components.count
                    )
                )
            )
        }

        return identifiableEntities
    }
}
