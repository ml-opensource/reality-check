//  RealityDump.swift
//  Created by Yasuhito NAGATOMO on 2022/02/18.
import Foundation
import RealityKit

#if DEBUG

    private let keywords = [  // (string, indentLevel [1...])
        ("Entity", 1),
        ("ModelEntity", 1),
        ("AnchorEntity", 1),
        ("Components", 2),
        ("Unknown Component", 3),
        ("Transform Component", 3),
        ("Synchronization Component", 3),
        ("Anchoring Component", 3),
        ("Model Component", 3),
        ("Collision Component", 3),
        ("PhysicsBody Component", 3),
        ("PhysicsMotion Component", 3),
        ("CharacterController Component", 3),
        ("CharacterControllerState Component", 3),
    ]

    /// Dump the RealityKit Entity object
    /// - Parameters:
    ///   - entity: Entity or ModelEntity or AnchorEntity
    ///   - printing: if true, strings are printed to the console.
    ///   - detail: 0 = simple, 1 = detailed
    ///   - org: true = Emacs org mode
    /// - Returns: dumped strings of the entity
    @discardableResult
    public func dumpRealityEntity(
        _ loadedEntity: Entity, printing: Bool = true, detail: Int = 1, org: Bool = true
    ) -> [String] {
        var strings = [String]()
        if org {
            strings.append("-*- mode:org -*-")
        }

        strings += dumpEntity(loadedEntity, detail: detail, nesting: 0)

        let orgStrings: [String]
        if org {
            let maxLevel = (keywords.map { $0.1 }.max() ?? 0) + 1
            orgStrings = strings.map { string -> String in
                var orgPrefix = ""
                let hitKeywords = keywords.compactMap { keyword in
                    string.contains(keyword.0) ? keyword : nil
                }
                if let keyword = hitKeywords.first {
                    orgPrefix =
                        String(repeating: "*", count: keyword.1)
                        + String(repeating: " ", count: maxLevel - keyword.1)
                } else {
                    orgPrefix = String(repeating: " ", count: maxLevel)
                }
                return orgPrefix + string
            }
        } else {
            orgStrings = strings
        }
        if printing {
            orgStrings.forEach { print($0) }
        }
        return orgStrings
    }

    private func dumpEntity(_ loadedEntity: Entity, detail: Int, nesting: Int) -> [String] {
        let indentCharacterNumber = 2
        let strings = entityToStrings(loadedEntity, detail: detail, nesting: nesting)
        let nestedStrings = strings.map { string -> String in
            String(repeating: " ", count: nesting * indentCharacterNumber) + string
        }
        return nestedStrings
    }

    private func entityToStrings(_ loadedEntity: Entity, detail: Int, nesting: Int) -> [String] {
        var strings = [String]()
        let modelEntity = loadedEntity as? ModelEntity
        let anchorEntity = loadedEntity as? AnchorEntity

        if anchorEntity != nil {
            strings.append("<a> \(keywords[2].0)")  // AnchorEntity
            if let anchorId = anchorEntity?.anchorIdentifier {
                strings.append("  +-- anchorIdentifier: \(anchorId)")
            }
        } else if modelEntity != nil {
            strings.append("<M> \(keywords[1].0)")  // ModelEntity
        } else {
            strings.append("<.> \(keywords[0].0)")  // Entity
        }
        strings.append("  +-- name: \(loadedEntity.name)")
        strings.append("  +-- id (Uint64): \(loadedEntity.id)")
        strings.append("  +-- State")
        strings.append("  |     +-- isEnabled: \(loadedEntity.isEnabled)")
        strings.append("  |     +-- isEnabledInHierarchy: \(loadedEntity.isEnabledInHierarchy)")
        strings.append("  |     +-- isActive: \(loadedEntity.isActive)")
        strings.append("  |     +-- isAnchored: \(loadedEntity.isAnchored)")
        strings.append("  +-- Animation")
        strings.append(
            "  |     +-- number of animations: \(loadedEntity.availableAnimations.count)")
        loadedEntity.availableAnimations.forEach { animation in
            strings.append("  |     +-- name: \(animation.name ?? "(none)")")
        }

        if let model = modelEntity {
            strings.append("  +-- Joint")
            strings.append("  |     +-- number of jointNames: \(model.jointNames.count)")
            model.jointNames.forEach { jointName in
                strings.append("  |     +-- jointName: \(jointName)")
            }
            strings.append("  |     +-- number of jointTransforms: \(model.jointTransforms.count)")
            model.jointTransforms.forEach { jointTransform in
                strings.append("  |     +-- jointTransform: \(jointTransform)")
            }
        }

        strings.append("  +-- Hierarhy")
        strings.append("  |     +-- has a parent: \(loadedEntity.parent == nil ? "No" : "Yes")")
        strings.append("  |     +-- number of children: \(loadedEntity.children.count)")
        strings.append("  +-- \(keywords[3].0)")  // "Components"
        strings.append("  |     +-- number of components: \(loadedEntity.components.count)")
        if loadedEntity.components.count != 0 {
            strings += componentsToStrings(loadedEntity.components, detail: detail)
        }
        // dumpStrings.append("  +-- Description: \(entity.debugDescription)")
        strings.append("  +-------------------------------------------------")

        loadedEntity.children.forEach { child in
            strings += dumpEntity(child, detail: detail, nesting: nesting + 1)
        }

        return strings
    }

    private func componentsToStrings(_ components: Entity.ComponentSet, detail: Int) -> [String] {
        let componentTypes: [Component.Type] = [
            Transform.self,
            SynchronizationComponent.self,
            AnchoringComponent.self,
            ModelComponent.self,
            CollisionComponent.self,
            PhysicsBodyComponent.self,
            PhysicsMotionComponent.self,
            CharacterControllerComponent.self,
            CharacterControllerStateComponent.self,
        ]
        var strings = [String]()

        componentTypes.forEach { type in
            if let component = components[type] {
                if let theComponent = component as? Transform {
                    strings += transformComponentToStrings(theComponent, detail: detail)
                } else if let theComponent = component as? SynchronizationComponent {
                    strings += syncComponentToStrings(theComponent, detail: detail)
                } else if let theComponent = component as? AnchoringComponent {
                    strings += anchoringComponentToStrings(theComponent, detail: detail)
                } else if let theComponent = component as? ModelComponent {
                    strings += modelComponentToStrings(theComponent, detail: detail)
                } else if let theComponent = component as? CollisionComponent {
                    strings += collisionComponentToStrings(theComponent, detail: detail)
                } else if let theComponent = component as? PhysicsBodyComponent {
                    strings += physicsBodyComponentToStrings(theComponent, detail: detail)
                } else if let theComponent = component as? PhysicsMotionComponent {
                    strings += physicsMotionComponentToStrings(theComponent, detail: detail)
                } else if let theComponent = component as? CharacterControllerComponent {
                    strings += characterControllerComponentToStrings(theComponent, detail: detail)
                } else if let theComponent = component as? CharacterControllerStateComponent {
                    strings += characterControllerStateComponentToStrings(
                        theComponent, detail: detail)
                } else {
                    strings.append("  |     +-- \(component)")
                }
            }
        }
        if components.count > componentTypes.count {
            strings.append("  |     +-- \(keywords[4].0)")  // "Unknown Component"
        }

        return strings
    }

    private func transformComponentToStrings(_ component: Transform, detail: Int) -> [String] {
        var strings = [String]()
        strings.append("  |     +-- \(keywords[5].0)")  // Transform Component
        if detail > 0 {
            strings.append("  |     |     +-- scale: \(component.scale)")
            strings.append("  |     |     +-- rotation: \(component.rotation)")
            strings.append("  |     |     +-- translation: \(component.translation)")
            strings.append("  |     |     +-- matrix: \(component.matrix)")
        }
        return strings
    }

    private func syncComponentToStrings(_ component: SynchronizationComponent, detail: Int)
        -> [String]
    {
        var strings = [String]()
        strings.append("  |     +-- \(keywords[6].0)")  // Synchronization Component
        return strings
    }

    private func anchoringComponentToStrings(_ component: AnchoringComponent, detail: Int)
        -> [String]
    {
        var strings = [String]()
        strings.append("  |     +-- \(keywords[7].0)")  // "Anchoring Component"
        return strings
    }

    private func modelComponentToStrings(_ component: ModelComponent, detail: Int) -> [String] {
        var strings = [String]()
        strings.append("  |     +-- \(keywords[8].0)")  // "Model Component"
        if detail > 0 {
            strings.append("  |     |     +-- bounding Box Margin: \(component.boundsMargin)")
            strings.append("  |     |     +-- mesh")
            strings.append(
                "  |     |     |    +-- expected Material Count: \(component.mesh.expectedMaterialCount)"
            )
            strings.append(
                "  |     |     |    +-- bounding Box - center: \(component.mesh.bounds.center)")
            strings.append(
                "  |     |     |    +-- resource - instances - count : \(component.mesh.contents.instances.count)"
            )
            strings.append(
                "  |     |     |    +-- resource - models - count : \(component.mesh.contents.models.count)"
            )
            strings.append("  |     |     +-- material")
            strings.append(
                "  |     |     |    +-- number of materials: \(component.materials.count)")
            component.materials.forEach { material in
                strings.append("  |     |     |    +-- material: \(type(of: material))")
            }
        }
        return strings
    }

    private func collisionComponentToStrings(_ component: CollisionComponent, detail: Int)
        -> [String]
    {
        var strings = [String]()
        strings.append("  |     +-- \(keywords[9].0)")  // "Collision Component"
        if detail > 0 {
            strings.append(
                "  |     |     +-- number of collision shapes: \(component.shapes.count)")
        }
        return strings
    }

    private func physicsBodyComponentToStrings(_ component: PhysicsBodyComponent, detail: Int)
        -> [String]
    {
        var strings = [String]()
        strings.append("  |     +-- \(keywords[10].0)")  // "PhysicsBody Component"
        if detail > 0 {
            strings.append(
                "  |     |     +-- isContinuousCollisionDetectionEnabled: \(component.isContinuousCollisionDetectionEnabled)"
            )
            strings.append("  |     |     +-- isRotationLocked: \(component.isRotationLocked)")
            strings.append("  |     |     +-- physics body mode: \(component.mode)")
            strings.append("  |     |     +-- mass [kg]: \(component.massProperties.mass)")
            strings.append("  |     |     +-- inertia [kg/m2]: \(component.massProperties.inertia)")
            strings.append(
                "  |     |     +-- center of mass: \(component.massProperties.centerOfMass)")
        }
        return strings
    }

    private func physicsMotionComponentToStrings(_ component: PhysicsMotionComponent, detail: Int)
        -> [String]
    {
        var strings = [String]()
        strings.append("  |     +-- \(keywords[11].0)")  // "PhysicsMotion Component"
        if detail > 0 {
            strings.append("  |     |     +-- anglar velocity: \(component.angularVelocity)")
            strings.append("  |     |     +-- linear velocity: \(component.linearVelocity)")
        }
        return strings
    }

    private func characterControllerComponentToStrings(
        _ component: CharacterControllerComponent, detail: Int
    ) -> [String] {
        var strings = [String]()
        strings.append("  |     +-- \(keywords[12].0)")  // "CharacterController Component"
        if detail > 0 {
            strings.append("  |     |     +-- (not be implemented.)")
        }
        return strings
    }
    private func characterControllerStateComponentToStrings(
        _ component: CharacterControllerStateComponent, detail: Int
    ) -> [String] {
        var strings = [String]()
        strings.append("  |     +-- \(keywords[13].0)")  // "CharacterControllerState Component"
        if detail > 0 {
            strings.append("  |     |     +-- (not be implemented.)")
        }
        return strings
    }
#else
    @discardableResult
    public func dumpRealityEntity(_ entity: Entity, printing: Bool = true) -> [String] { [] }
#endif
