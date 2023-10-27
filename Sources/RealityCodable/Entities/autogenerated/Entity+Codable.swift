// This file was automatically generated and should not be edited.

import Foundation
import Models
import RealityDump
import RealityKit

//MARK: - iOS

//MARK: AnchorEntity

extension RealityPlatform.iOS {
  public class AnchorEntity: RealityPlatform.iOS.Entity {

    #if os(iOS)
      init(rawValue entity: RealityKit.Entity) {
        super.init(entity)
      }
    #endif

    required init(from decoder: Decoder) throws {
      try super.init(from: decoder)
    }
  }
}

//MARK: BodyTrackedEntity

extension RealityPlatform.iOS {
  public class BodyTrackedEntity: RealityPlatform.iOS.Entity {

    #if os(iOS)
      init(rawValue entity: RealityKit.Entity) {
        super.init(entity)
      }
    #endif

    required init(from decoder: Decoder) throws {
      try super.init(from: decoder)
    }
  }
}

//MARK: DirectionalLight

extension RealityPlatform.iOS {
  public class DirectionalLight: RealityPlatform.iOS.Entity {

    #if os(iOS)
      init(rawValue entity: RealityKit.Entity) {
        super.init(entity)
      }
    #endif

    required init(from decoder: Decoder) throws {
      try super.init(from: decoder)
    }
  }
}

//MARK: Entity

extension RealityPlatform.iOS {
  public class Entity: Codable, Identifiable {
    private(set) public var accessibilityDescription: String?
    private(set) public var accessibilityLabel: String?
    private(set) public var children: [RealityPlatform.iOS.EntityType] = []
    private(set) public var components: [RealityPlatform.iOS.Component] = []
    public let id: UInt64
    public let isAccessibilityElement: Bool
    public let isActive: Bool
    public let isAnchored: Bool
    public let isEnabled: Bool
    public let isEnabledInHierarchy: Bool
    public let isOwner: Bool
    private(set) public var name: String?
    private(set) public var parentID: UInt64?

    #if os(iOS)
      init(
        _ entity: RealityKit.Entity
      ) {
        self.accessibilityDescription = entity.accessibilityDescription
        self.accessibilityLabel = entity.accessibilityLabel
        self.children = entity.children.map(\.encoded)
        self.components = entity.components.encoded
        self.id = entity.id
        self.isAccessibilityElement = entity.isAccessibilityElement
        self.isActive = entity.isActive
        self.isAnchored = entity.isAnchored
        self.isEnabled = entity.isEnabled
        self.isEnabledInHierarchy = entity.isEnabledInHierarchy
        self.isOwner = entity.isOwner
        self.name = entity.name
        self.parentID = entity.parent?.id
      }
    #endif
  }
}

extension RealityPlatform.iOS.Entity: Equatable {
  public static func == (lhs: RealityPlatform.iOS.Entity, rhs: RealityPlatform.iOS.Entity) -> Bool {
    lhs.id == rhs.id
  }
}

//MARK: ModelEntity

extension RealityPlatform.iOS {
  public class ModelEntity: RealityPlatform.iOS.Entity {

    #if os(iOS)
      init(rawValue entity: RealityKit.Entity) {
        super.init(entity)
      }
    #endif

    required init(from decoder: Decoder) throws {
      try super.init(from: decoder)
    }
  }
}

//MARK: PerspectiveCamera

extension RealityPlatform.iOS {
  public class PerspectiveCamera: RealityPlatform.iOS.Entity {

    #if os(iOS)
      init(rawValue entity: RealityKit.Entity) {
        super.init(entity)
      }
    #endif

    required init(from decoder: Decoder) throws {
      try super.init(from: decoder)
    }
  }
}

//MARK: PointLight

extension RealityPlatform.iOS {
  public class PointLight: RealityPlatform.iOS.Entity {

    #if os(iOS)
      init(rawValue entity: RealityKit.Entity) {
        super.init(entity)
      }
    #endif

    required init(from decoder: Decoder) throws {
      try super.init(from: decoder)
    }
  }
}

//MARK: SpotLight

extension RealityPlatform.iOS {
  public class SpotLight: RealityPlatform.iOS.Entity {

    #if os(iOS)
      init(rawValue entity: RealityKit.Entity) {
        super.init(entity)
      }
    #endif

    required init(from decoder: Decoder) throws {
      try super.init(from: decoder)
    }
  }
}

//MARK: TriggerVolume

extension RealityPlatform.iOS {
  public class TriggerVolume: RealityPlatform.iOS.Entity {

    #if os(iOS)
      init(rawValue entity: RealityKit.Entity) {
        super.init(entity)
      }
    #endif

    required init(from decoder: Decoder) throws {
      try super.init(from: decoder)
    }
  }
}

//MARK: - macOS

//MARK: AnchorEntity

extension RealityPlatform.macOS {
  public class AnchorEntity: RealityPlatform.macOS.Entity {

    #if os(macOS)
      init(rawValue entity: RealityKit.Entity) {
        super.init(entity)
      }
    #endif

    required init(from decoder: Decoder) throws {
      try super.init(from: decoder)
    }
  }
}

//MARK: DirectionalLight

extension RealityPlatform.macOS {
  public class DirectionalLight: RealityPlatform.macOS.Entity {

    #if os(macOS)
      init(rawValue entity: RealityKit.Entity) {
        super.init(entity)
      }
    #endif

    required init(from decoder: Decoder) throws {
      try super.init(from: decoder)
    }
  }
}

//MARK: Entity

extension RealityPlatform.macOS {
  public class Entity: Codable, Identifiable {
    private(set) public var accessibilityDescription: String?
    private(set) public var accessibilityLabel: String?
    private(set) public var children: [RealityPlatform.macOS.EntityType] = []
    private(set) public var components: [RealityPlatform.macOS.Component] = []
    public let id: UInt64
    public let isAccessibilityElement: Bool
    public let isActive: Bool
    public let isAnchored: Bool
    public let isEnabled: Bool
    public let isEnabledInHierarchy: Bool
    public let isOwner: Bool
    private(set) public var name: String?
    private(set) public var parentID: UInt64?

    #if os(macOS)
      init(
        _ entity: RealityKit.Entity
      ) {
        self.accessibilityDescription = entity.accessibilityDescription
        self.accessibilityLabel = entity.accessibilityLabel
        self.children = entity.children.map(\.encoded)
        self.components = entity.components.encoded
        self.id = entity.id
        self.isAccessibilityElement = entity.isAccessibilityElement
        self.isActive = entity.isActive
        self.isAnchored = entity.isAnchored
        self.isEnabled = entity.isEnabled
        self.isEnabledInHierarchy = entity.isEnabledInHierarchy
        self.isOwner = entity.isOwner
        self.name = entity.name
        self.parentID = entity.parent?.id
      }
    #endif
  }
}

extension RealityPlatform.macOS.Entity: Equatable {
  public static func == (
    lhs: RealityPlatform.macOS.Entity,
    rhs: RealityPlatform.macOS.Entity
  ) -> Bool {
    lhs.id == rhs.id
  }
}

//MARK: ModelEntity

extension RealityPlatform.macOS {
  public class ModelEntity: RealityPlatform.macOS.Entity {

    #if os(macOS)
      init(rawValue entity: RealityKit.Entity) {
        super.init(entity)
      }
    #endif

    required init(from decoder: Decoder) throws {
      try super.init(from: decoder)
    }
  }
}

//MARK: PerspectiveCamera

extension RealityPlatform.macOS {
  public class PerspectiveCamera: RealityPlatform.macOS.Entity {

    #if os(macOS)
      init(rawValue entity: RealityKit.Entity) {
        super.init(entity)
      }
    #endif

    required init(from decoder: Decoder) throws {
      try super.init(from: decoder)
    }
  }
}

//MARK: PointLight

extension RealityPlatform.macOS {
  public class PointLight: RealityPlatform.macOS.Entity {

    #if os(macOS)
      init(rawValue entity: RealityKit.Entity) {
        super.init(entity)
      }
    #endif

    required init(from decoder: Decoder) throws {
      try super.init(from: decoder)
    }
  }
}

//MARK: SpotLight

extension RealityPlatform.macOS {
  public class SpotLight: RealityPlatform.macOS.Entity {

    #if os(macOS)
      init(rawValue entity: RealityKit.Entity) {
        super.init(entity)
      }
    #endif

    required init(from decoder: Decoder) throws {
      try super.init(from: decoder)
    }
  }
}

//MARK: TriggerVolume

extension RealityPlatform.macOS {
  public class TriggerVolume: RealityPlatform.macOS.Entity {

    #if os(macOS)
      init(rawValue entity: RealityKit.Entity) {
        super.init(entity)
      }
    #endif

    required init(from decoder: Decoder) throws {
      try super.init(from: decoder)
    }
  }
}

//MARK: - visionOS

//MARK: AnchorEntity

extension RealityPlatform.visionOS {
  public class AnchorEntity: RealityPlatform.visionOS.Entity {

    #if os(visionOS)
      init(rawValue entity: RealityKit.Entity) {
        super.init(entity)
      }
    #endif

    required init(from decoder: Decoder) throws {
      try super.init(from: decoder)
    }
  }
}

//MARK: Entity

extension RealityPlatform.visionOS {
  public class Entity: Codable, Identifiable {
    private(set) public var accessibilityDescription: String?
    private(set) public var accessibilityLabel: String?
    private(set) public var children: [RealityPlatform.visionOS.EntityType] = []
    private(set) public var components: [RealityPlatform.visionOS.Component] = []
    public let id: UInt64
    public let isAccessibilityElement: Bool
    public let isActive: Bool
    public let isAnchored: Bool
    public let isEnabled: Bool
    public let isEnabledInHierarchy: Bool
    public let isOwner: Bool
    private(set) public var name: String?
    private(set) public var parentID: UInt64?

    #if os(visionOS)
      init(
        _ entity: RealityKit.Entity
      ) {
        self.accessibilityDescription = entity.accessibilityDescription
        //FIXME: self.accessibilityLabel = entity.accessibilityLabel
        self.children = entity.children.map(\.encoded)
        self.components = entity.components.encoded
        self.id = entity.id
        self.isAccessibilityElement = entity.isAccessibilityElement
        self.isActive = entity.isActive
        self.isAnchored = entity.isAnchored
        self.isEnabled = entity.isEnabled
        self.isEnabledInHierarchy = entity.isEnabledInHierarchy
        self.isOwner = entity.isOwner
        self.name = entity.name
        self.parentID = entity.parent?.id
      }
    #endif
  }
}

extension RealityPlatform.visionOS.Entity: Equatable {
  public static func == (
    lhs: RealityPlatform.visionOS.Entity,
    rhs: RealityPlatform.visionOS.Entity
  ) -> Bool {
    lhs.id == rhs.id
  }
}

//MARK: ModelEntity

extension RealityPlatform.visionOS {
  public class ModelEntity: RealityPlatform.visionOS.Entity {

    #if os(visionOS)
      init(rawValue entity: RealityKit.Entity) {
        super.init(entity)
      }
    #endif

    required init(from decoder: Decoder) throws {
      try super.init(from: decoder)
    }
  }
}

//MARK: PerspectiveCamera

extension RealityPlatform.visionOS {
  public class PerspectiveCamera: RealityPlatform.visionOS.Entity {

    #if os(visionOS)
      init(rawValue entity: RealityKit.Entity) {
        super.init(entity)
      }
    #endif

    required init(from decoder: Decoder) throws {
      try super.init(from: decoder)
    }
  }
}

//MARK: TriggerVolume

extension RealityPlatform.visionOS {
  public class TriggerVolume: RealityPlatform.visionOS.Entity {

    #if os(visionOS)
      init(rawValue entity: RealityKit.Entity) {
        super.init(entity)
      }
    #endif

    required init(from decoder: Decoder) throws {
      try super.init(from: decoder)
    }
  }
}
