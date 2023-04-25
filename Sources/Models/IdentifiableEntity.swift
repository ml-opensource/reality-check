import Foundation

public struct IdentifiableEntity: Identifiable, Hashable {
    public let id: UInt64
    public var anchorIdentifier: UUID?
    public var name: String?
    public let type: EntityType
    public var children: [IdentifiableEntity]? = nil
    public var state: State
    public var hierarhy: Hierarhy
    public var components: Components

    public enum EntityType: Codable {
        case anchor
        case model
        case entity
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
        public let childrenCount: Int

        public init(
            hasParent: Bool,
            childrenCount: Int
        ) {
            self.hasParent = hasParent
            self.childrenCount = childrenCount
        }
    }

    public struct Components: Equatable, Hashable {
        public let componentsCount: Int
        // public let components: Entity.ComponentSet
        
        public init(
            componentsCount: Int
        ) {
            self.componentsCount = componentsCount
        }
    }

    public init(
        id: UInt64,
        anchorIdentifier: UUID? = nil,
        name: String? = nil,
        type: EntityType,
        children: [IdentifiableEntity]? = nil,
        state: State,
        hierarhy: Hierarhy,
        components: Components
    ) {
        self.id = id
        self.anchorIdentifier = anchorIdentifier
        self.name = name
        self.type = type
        self.children = children
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
        case .model:
            return "ModelEntity"
        case .entity:
            return "Entity"
        }
    }
}

extension IdentifiableEntity.EntityType {
    public var symbol: String {
        switch self {
        case .anchor:
            return "arrow.down.to.line.compact"
        case .model:
            return "cube"
        case .entity:
            return "move.3d"
        }
    }
}

// MARK: - Mock

extension IdentifiableEntity {
    public static var mock: Self = .init(
        id: 7_928_071_431_998_189_885,
        anchorIdentifier: UUID(uuidString: "D156D1A0-DC0E-4054-A479-601ED51B0A63"),
        name: "Le Anchor",
        type: .anchor,
        children: [],
        state: .init(
            isEnabled: true,
            isEnabledInHierarchy: true,
            isActive: true,
            isAnchored: true
        ),
        hierarhy: .init(
            hasParent: false,
            childrenCount: 77
        ),
        components: .init(
            componentsCount: 5
        )
    )
}
