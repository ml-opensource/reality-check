import Foundation
import RealityKit

public struct IdentifiableEntity: Identifiable, Hashable {
    public let id: UInt64
    public var anchorIdentifier: UUID?
    public var name: String?
    public let type: EntityType
    public var children: [IdentifiableEntity]? {
        hierarhy.children.isEmpty ? nil : hierarhy.children
    }
    public var state: State
    public var hierarhy: Hierarhy
    public var components: Components

    public enum EntityType: CaseIterable, RawRepresentable {
        case anchor
        // case bodyTrackedEntity
        case directionalLight
        case entity
        case model
        case perspectiveCamera
        case pointLight
        case spotLight
        case triggerVolume

        public var rawValue: Entity.Type {
            switch self {
            case .anchor:
                return AnchorEntity.self
            // case .bodyTrackedEntity:
            //     return AnchorEntity.self
            case .directionalLight:
                return DirectionalLight.self
            case .entity:
                return Entity.self
            case .model:
                return ModelEntity.self
            case .perspectiveCamera:
                return PerspectiveCamera.self
            case .pointLight:
                return PointLight.self
            case .spotLight:
                return SpotLight.self
            case .triggerVolume:
                return TriggerVolume.self
            }
        }

        public init?(rawValue: Entity.Type) {
            for entityType in Self.allCases {
                if entityType.rawValue == rawValue {
                    self = entityType
                    return
                }
            }
            //TODO: handle unknown entities
            fatalError("Unknown Entity.Type")
        }
    }

    public struct State: Equatable, Hashable {
        public let isEnabled: Bool
        public let isEnabledInHierarchy: Bool
        public let isActive: Bool
        public let isAnchored: Bool

        public init(
            isEnabled: Bool,
            isEnabledInHierarchy: Bool,
            isActive: Bool,
            isAnchored: Bool
        ) {
            self.isEnabled = isEnabled
            self.isEnabledInHierarchy = isEnabledInHierarchy
            self.isActive = isActive
            self.isAnchored = isAnchored
        }
    }

    public struct Hierarhy: Equatable, Hashable {
        public let hasParent: Bool
        public var childrenCount: Int { children.count }
        public var children: [IdentifiableEntity]

        public init(
            children: [IdentifiableEntity],
            hasParent: Bool
        ) {
            self.children = children
            self.hasParent = hasParent
        }
    }

    public struct Components: Equatable, Hashable {
        public let components: [IdentifiableComponent]
        public var count: Int { components.count }

        public init(
            components: [IdentifiableComponent]
        ) {
            self.components = components
        }
    }

    // public init(
    //     id: UInt64,
    //     anchorIdentifier: UUID? = nil,
    //     name: String? = nil,
    //     type: EntityType,
    //     state: IdentifiableEntity.State,
    //     hierarhy: IdentifiableEntity.Hierarhy,
    //     components: IdentifiableEntity.Components
    // ) {
    //     self.id = id
    //     self.anchorIdentifier = anchorIdentifier
    //     self.name = name
    //     self.type = type
    //     self.state = state
    //     self.hierarhy = hierarhy
    //     self.components = components
    // }

    public init(
        _ entity: RealityKit.Entity,
        state: IdentifiableEntity.State,
        hierarhy: IdentifiableEntity.Hierarhy,
        components: IdentifiableEntity.Components
    ) {
        self.id = entity.id
        //FIXME
        // self.anchorIdentifier = entity.anchorIdentifier
        self.name = entity.name
        self.type = .init(rawValue: Swift.type(of: entity))!
        self.state = state
        self.hierarhy = hierarhy
        self.components = components
    }
}

extension IdentifiableEntity.EntityType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .anchor:
            return "AnchorEntity"
        // case .bodyTrackedEntity:
        //     return "BodyTrackedEntity"
        case .directionalLight:
            return "DirectionalLight"
        case .entity:
            return "Entity"
        case .model:
            return "ModelEntity"
        case .perspectiveCamera:
            return "PerspectiveCamera"
        case .pointLight:
            return "PointLight"
        case .spotLight:
            return "SpotLight"
        case .triggerVolume:
            return "TriggerVolume"
        }
    }
}

extension IdentifiableEntity.EntityType {
    public var symbol: String {
        switch self {
        case .anchor:
            return "arrow.down.to.line"
        // case .bodyTrackedEntity:
        //     return "figure.walk"
        case .directionalLight:
            return "sun.max"
        case .entity:
            return "move.3d"
        case .model:
            return "cube"
        case .perspectiveCamera:
            return "camera"
        case .pointLight:
            return "lightbulb.led"
        case .spotLight:
            return "lamp.desk"
        case .triggerVolume:
            return "cube.transparent"
        }
    }
}

extension IdentifiableEntity.EntityType {
    public var help: String {
        switch self {
        case .anchor:
            return """
                An anchor that tethers entities to a scene.
                """
        // case .bodyTrackedEntity:
        //     return """
        //         An entity used to animate a virtual character in an AR scene by tracking a real person.
        //         """
        case .directionalLight:
            return """
                An entity that casts a virtual light in a particular direction.
                """
        case .entity:
            return """
                An element of a RealityKit scene to which you attach components that provide appearance and behavior characteristics for the entity.
                """
        case .model:
            return """
                A representation of a physical object that RealityKit renders and optionally simulates.
                """
        case .perspectiveCamera:
            return """
                A virtual camera that establishes the rendering perspective.
                """
        case .pointLight:
            return """
                An entity that produces an omnidirectional light for virtual objects.
                """
        case .spotLight:
            return """
                An entity that illuminates virtual content in a cone-shaped volume.
                """
        case .triggerVolume:
            return
                """
                An invisible 3D shape that detects when objects enter or exit a given region of space.
                """
        }
    }
}

//MARK: -

extension Entity.ComponentSet: Equatable {
    //FIXME: Find a better way to use equatable or use another type instear `Entity.ComponentSet`

    public static func == (lhs: Entity.ComponentSet, rhs: Entity.ComponentSet) -> Bool {
        lhs.count == rhs.count
    }
}
