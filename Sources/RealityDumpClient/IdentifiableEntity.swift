import Foundation

public struct IdentifiableEntity: Identifiable, Hashable {
    public enum EntityType: Codable {
        case anchor
        case model
        case entity
    }

    public let id: UInt64
    public var anchorIdentifier: UUID?
    public var name: String?
    public let type: EntityType
    public var children: [IdentifiableEntity]? = nil
    public var state: State
    public var hierarhy: Hierarhy
    public var components: Components

    public struct State: Equatable, Hashable {
        public let isEnabled: Bool
        public let isEnabledInHierarchy: Bool
        public let isActive: Bool
        public let isAnchored: Bool
    }

    public struct Hierarhy: Equatable, Hashable {
        public let hasParent: Bool
        public let childrenCount: Int
    }

    public struct Components: Equatable, Hashable {
        public let componentsCount: Int
        // public let components: Entity.ComponentSet
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
