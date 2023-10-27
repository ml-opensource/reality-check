// This file was automatically generated and should not be edited.

import Foundation
import RealityKit

//MARK: - iOS


extension RealityPlatform.iOS {
  public enum EntityType: Equatable {
    case anchorEntity(AnchorEntity)
    case bodyTrackedEntity(BodyTrackedEntity)
    case directionalLight(DirectionalLight)
    case entity(Entity)
    case modelEntity(ModelEntity)
    case perspectiveCamera(PerspectiveCamera)
    case pointLight(PointLight)
    case spotLight(SpotLight)
    case triggerVolume(TriggerVolume)
  }
}

extension RealityPlatform.iOS.EntityType: Codable {
  public var caseKey: String {
    switch self {
      case .anchorEntity: return "AnchorEntity"
      case .bodyTrackedEntity: return "BodyTrackedEntity"
      case .directionalLight: return "DirectionalLight"
      case .entity: return "Entity"
      case .modelEntity: return "ModelEntity"
      case .perspectiveCamera: return "PerspectiveCamera"
      case .pointLight: return "PointLight"
      case .spotLight: return "SpotLight"
      case .triggerVolume: return "TriggerVolume"
    }
  }
  
  public var value: RealityPlatform.iOS.Entity {
    switch self {
      case .anchorEntity(let value): return value
      case .bodyTrackedEntity(let value): return value
      case .directionalLight(let value): return value
      case .entity(let value): return value
      case .modelEntity(let value): return value
      case .perspectiveCamera(let value): return value
      case .pointLight(let value): return value
      case .spotLight(let value): return value
      case .triggerVolume(let value): return value
    }
  }

  enum CodingKeys: String, CodingKey {
    case caseKey
    case value
  }

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    let caseKey = try values.decode(String.self, forKey: .caseKey)
    
    switch caseKey {
      case "AnchorEntity":
        let value = try values.decode(RealityPlatform.iOS.AnchorEntity.self, forKey: .value)
        self = .anchorEntity(value)
      case "BodyTrackedEntity":
        let value = try values.decode(RealityPlatform.iOS.BodyTrackedEntity.self, forKey: .value)
        self = .bodyTrackedEntity(value)
      case "DirectionalLight":
        let value = try values.decode(RealityPlatform.iOS.DirectionalLight.self, forKey: .value)
        self = .directionalLight(value)
      case "Entity":
        let value = try values.decode(RealityPlatform.iOS.Entity.self, forKey: .value)
        self = .entity(value)
      case "ModelEntity":
        let value = try values.decode(RealityPlatform.iOS.ModelEntity.self, forKey: .value)
        self = .modelEntity(value)
      case "PerspectiveCamera":
        let value = try values.decode(RealityPlatform.iOS.PerspectiveCamera.self, forKey: .value)
        self = .perspectiveCamera(value)
      case "PointLight":
        let value = try values.decode(RealityPlatform.iOS.PointLight.self, forKey: .value)
        self = .pointLight(value)
      case "SpotLight":
        let value = try values.decode(RealityPlatform.iOS.SpotLight.self, forKey: .value)
        self = .spotLight(value)
      case "TriggerVolume":
        let value = try values.decode(RealityPlatform.iOS.TriggerVolume.self, forKey: .value)
        self = .triggerVolume(value)
      default:
        fatalError("Unknown iOS Entity type.")
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(caseKey, forKey: .caseKey)

    switch self {
      case .anchorEntity(let value):
        try container.encode(value, forKey: .value)
      case .bodyTrackedEntity(let value):
        try container.encode(value, forKey: .value)
      case .directionalLight(let value):
        try container.encode(value, forKey: .value)
      case .entity(let value):
        try container.encode(value, forKey: .value)
      case .modelEntity(let value):
        try container.encode(value, forKey: .value)
      case .perspectiveCamera(let value):
        try container.encode(value, forKey: .value)
      case .pointLight(let value):
        try container.encode(value, forKey: .value)
      case .spotLight(let value):
        try container.encode(value, forKey: .value)
      case .triggerVolume(let value):
        try container.encode(value, forKey: .value)
    }
  }
}

//MARK: - macOS


extension RealityPlatform.macOS {
  public enum EntityType: Equatable {
    case anchorEntity(AnchorEntity)
    case directionalLight(DirectionalLight)
    case entity(Entity)
    case modelEntity(ModelEntity)
    case perspectiveCamera(PerspectiveCamera)
    case pointLight(PointLight)
    case spotLight(SpotLight)
    case triggerVolume(TriggerVolume)
  }
}

extension RealityPlatform.macOS.EntityType: Codable {
  public var caseKey: String {
    switch self {
      case .anchorEntity: return "AnchorEntity"
      case .directionalLight: return "DirectionalLight"
      case .entity: return "Entity"
      case .modelEntity: return "ModelEntity"
      case .perspectiveCamera: return "PerspectiveCamera"
      case .pointLight: return "PointLight"
      case .spotLight: return "SpotLight"
      case .triggerVolume: return "TriggerVolume"
    }
  }
  
  public var value: RealityPlatform.macOS.Entity {
    switch self {
      case .anchorEntity(let value): return value
      case .directionalLight(let value): return value
      case .entity(let value): return value
      case .modelEntity(let value): return value
      case .perspectiveCamera(let value): return value
      case .pointLight(let value): return value
      case .spotLight(let value): return value
      case .triggerVolume(let value): return value
    }
  }

  enum CodingKeys: String, CodingKey {
    case caseKey
    case value
  }

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    let caseKey = try values.decode(String.self, forKey: .caseKey)
    
    switch caseKey {
      case "AnchorEntity":
        let value = try values.decode(RealityPlatform.macOS.AnchorEntity.self, forKey: .value)
        self = .anchorEntity(value)
      case "DirectionalLight":
        let value = try values.decode(RealityPlatform.macOS.DirectionalLight.self, forKey: .value)
        self = .directionalLight(value)
      case "Entity":
        let value = try values.decode(RealityPlatform.macOS.Entity.self, forKey: .value)
        self = .entity(value)
      case "ModelEntity":
        let value = try values.decode(RealityPlatform.macOS.ModelEntity.self, forKey: .value)
        self = .modelEntity(value)
      case "PerspectiveCamera":
        let value = try values.decode(RealityPlatform.macOS.PerspectiveCamera.self, forKey: .value)
        self = .perspectiveCamera(value)
      case "PointLight":
        let value = try values.decode(RealityPlatform.macOS.PointLight.self, forKey: .value)
        self = .pointLight(value)
      case "SpotLight":
        let value = try values.decode(RealityPlatform.macOS.SpotLight.self, forKey: .value)
        self = .spotLight(value)
      case "TriggerVolume":
        let value = try values.decode(RealityPlatform.macOS.TriggerVolume.self, forKey: .value)
        self = .triggerVolume(value)
      default:
        fatalError("Unknown macOS Entity type.")
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(caseKey, forKey: .caseKey)

    switch self {
      case .anchorEntity(let value):
        try container.encode(value, forKey: .value)
      case .directionalLight(let value):
        try container.encode(value, forKey: .value)
      case .entity(let value):
        try container.encode(value, forKey: .value)
      case .modelEntity(let value):
        try container.encode(value, forKey: .value)
      case .perspectiveCamera(let value):
        try container.encode(value, forKey: .value)
      case .pointLight(let value):
        try container.encode(value, forKey: .value)
      case .spotLight(let value):
        try container.encode(value, forKey: .value)
      case .triggerVolume(let value):
        try container.encode(value, forKey: .value)
    }
  }
}

//MARK: - visionOS


extension RealityPlatform.visionOS {
  public enum EntityType: Equatable {
    case anchorEntity(AnchorEntity)
    case entity(Entity)
    case modelEntity(ModelEntity)
    case perspectiveCamera(PerspectiveCamera)
    case triggerVolume(TriggerVolume)
  }
}

extension RealityPlatform.visionOS.EntityType: Codable {
  public var caseKey: String {
    switch self {
      case .anchorEntity: return "AnchorEntity"
      case .entity: return "Entity"
      case .modelEntity: return "ModelEntity"
      case .perspectiveCamera: return "PerspectiveCamera"
      case .triggerVolume: return "TriggerVolume"
    }
  }
  
  public var value: RealityPlatform.visionOS.Entity {
    switch self {
      case .anchorEntity(let value): return value
      case .entity(let value): return value
      case .modelEntity(let value): return value
      case .perspectiveCamera(let value): return value
      case .triggerVolume(let value): return value
    }
  }

  enum CodingKeys: String, CodingKey {
    case caseKey
    case value
  }

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    let caseKey = try values.decode(String.self, forKey: .caseKey)
    
    switch caseKey {
      case "AnchorEntity":
        let value = try values.decode(RealityPlatform.visionOS.AnchorEntity.self, forKey: .value)
        self = .anchorEntity(value)
      case "Entity":
        let value = try values.decode(RealityPlatform.visionOS.Entity.self, forKey: .value)
        self = .entity(value)
      case "ModelEntity":
        let value = try values.decode(RealityPlatform.visionOS.ModelEntity.self, forKey: .value)
        self = .modelEntity(value)
      case "PerspectiveCamera":
        let value = try values.decode(RealityPlatform.visionOS.PerspectiveCamera.self, forKey: .value)
        self = .perspectiveCamera(value)
      case "TriggerVolume":
        let value = try values.decode(RealityPlatform.visionOS.TriggerVolume.self, forKey: .value)
        self = .triggerVolume(value)
      default:
        fatalError("Unknown visionOS Entity type.")
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(caseKey, forKey: .caseKey)

    switch self {
      case .anchorEntity(let value):
        try container.encode(value, forKey: .value)
      case .entity(let value):
        try container.encode(value, forKey: .value)
      case .modelEntity(let value):
        try container.encode(value, forKey: .value)
      case .perspectiveCamera(let value):
        try container.encode(value, forKey: .value)
      case .triggerVolume(let value):
        try container.encode(value, forKey: .value)
    }
  }
}
