import CustomDump
import Foundation
import RealityKit

public struct IdentifiableEntity: Equatable, Identifiable, Hashable, Codable {
  public static func == (lhs: IdentifiableEntity, rhs: IdentifiableEntity) -> Bool {
    lhs.id == rhs.id
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(self.id)
  }

  public var id: UInt64
  public let isAccessibilityElement: Bool
  public let accessibilityLabel: String?
  public let accessibilityDescription: String?
  public var anchorIdentifier: UUID?
  public var availableAnimations: [CodableAnimationResource]
  public var name: String?
  public let entityType: EntityType
  public var children: [IdentifiableEntity]? {
    hierarhy.children.isEmpty ? nil : hierarhy.children
  }
  public var state: State
  public var hierarhy: Hierarhy
  public var components: Components

  public enum EntityType: CaseIterable, Codable {
    case anchor
    // case bodyTrackedEntity
    case directionalLight
    case entity
    case model
    case perspectiveCamera
    case pointLight
    case spotLight
    case triggerVolume
  }

  public struct State: Equatable, Hashable, Codable {
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

  public struct Hierarhy: Codable {

    public let parentID: UInt64?
    public var childrenCount: Int { children.count }
    public var children: [IdentifiableEntity]

    public init(
      children: [IdentifiableEntity],
      parentID: UInt64?
    ) {
      self.children = children
      self.parentID = parentID
    }
  }

  public struct Components: Equatable, Hashable, Codable {
    public let components: [IdentifiableComponent]
    public var count: Int { components.count }

    public init(
      components: [IdentifiableComponent]
    ) {
      self.components = components
    }
  }

  public init(
    _ entity: RealityKit.Entity,
    state: IdentifiableEntity.State,
    hierarhy: IdentifiableEntity.Hierarhy,
    components: IdentifiableEntity.Components
  ) {
    #if !os(visionOS)
      if let anchor = entity as? AnchorEntity {
        self.anchorIdentifier = anchor.anchorIdentifier
      }
    #endif
    self.id = entity.id
    self.isAccessibilityElement = entity.isAccessibilityElement
    self.accessibilityLabel = entity.accessibilityLabel
    self.accessibilityDescription = entity.accessibilityDescription
    self.availableAnimations = entity.availableAnimations.compactMap(CodableAnimationResource.init)
    self.name = entity.name
    self.entityType = .init(rawValue: Swift.type(of: entity)) ?? .entity
    self.state = state
    self.hierarhy = hierarhy
    self.components = components
  }
}

extension IdentifiableEntity.EntityType: RawRepresentable {
  public var rawValue: Entity.Type {
    switch self {
      case .anchor:
        return AnchorEntity.self
      // case .bodyTrackedEntity:
      //     return AnchorEntity.self

      case .directionalLight:
        #if !os(visionOS)
          return DirectionalLight.self
        #endif
        fatalError()

      case .entity:
        return Entity.self

      case .model:
        return ModelEntity.self

      case .perspectiveCamera:
        return PerspectiveCamera.self

      case .pointLight:
        #if !os(visionOS)
          return PointLight.self
        #endif
        fatalError()

      case .spotLight:
        #if !os(visionOS)
          return SpotLight.self
        #endif
        fatalError()

      case .triggerVolume:
        return TriggerVolume.self
    }
  }

  public init?(
    rawValue: Entity.Type
  ) {
    for entityType in Self.allCases {
      if entityType.rawValue == rawValue {
        self = entityType
        return
      } else {
        self = .entity
        return
      }
    }
    //TODO: handle unknown/custom entities
    fatalError("Unknown Entity.Type")
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

extension IdentifiableEntity.State: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(
      self,
      children: [
        "isEnabled": self.isEnabled,
        "isEnabledInHierarchy": self.isEnabledInHierarchy,
        "isActive": self.isActive,
        "isAnchored": self.isAnchored,
      ],
      displayStyle: .dictionary
    )
  }
}

extension IdentifiableEntity.Hierarhy: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(
      self,
      children: [
        "hasParent": self.hasParent,
        "children": self.children,
      ],
      displayStyle: .dictionary
    )
  }
}

extension IdentifiableEntity.Components: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(
      self,
      children: [
        "_items": self.components
      ],
      displayStyle: .collection
    )
  }
}

//extension IdentifiableEntity: CustomDumpStringConvertible {
//  public var customDumpDescription: String {
//    """
//    Anchor(
//      id: \(self.id),
//      components: \(String(customDumping: self.components))
//
//    )
//    """
//  }
//}

extension IdentifiableEntity: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(
      self,
      children: [
        "id": self.id,
        "isAccessibilityElement": self.isAccessibilityElement,
        "accessibilityLabel": self.accessibilityLabel,
        "accessibilityDescription": self.accessibilityDescription,
        "anchorIdentifier": self.anchorIdentifier,
        "availableAnimations": self.availableAnimations,
        "name": self.name,
        "entityType": self.entityType,
        "state": self.state,
        "hierarhy": self.hierarhy,
        "components": self.components.components,
      ],
      displayStyle: .struct
    )
  }
}
