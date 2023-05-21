import Foundation
import RealityKit

public struct AnchoringComponentProperties: ComponentPropertiesRepresentable {
  /// The kind of real world object to which the anchor entity should anchor.
  public let target: CodableTarget
}

public enum CodableTarget: Codable {

    case camera
    case world(transform: CodableFloat4x4)
    case anchor(identifier: UUID)
    case plane([UInt8], classifications: [UInt64], minimumBounds: SIMD2<Float>)
    case image(group: String, name: String)
    case object(group: String, name: String)
    case face
    case body

    private enum CodingKeys: String, CodingKey {
        case camera
        case world
        case anchor
        case plane
        case image
        case object
        case face
        case body
    }
  
  public init(
    _ target: AnchoringComponent.Target
  ) {
    switch target {
      case .camera:
        self = .camera
      case .world(let transform):
        self = .world(transform: CodableFloat4x4(transform))
      #if os(iOS)
      case .anchor(let identifier):
        self = .anchor(identifier: identifier)
      case .plane(let alignment, let classification, let minimumBounds):
      self = .plane([alignment.rawValue], classifications: [classification.rawValue], minimumBounds: minimumBounds)
      case .image(let group, let name):
        self = .image(group: group, name: name)
      case .object(let group, let name):
        self = .object(group: group, name: name)
      case .face:
        self = .face
      case .body:
        self = .body
      #endif
      @unknown default:
        fatalError()
    }
  }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.camera) {
            self = .camera
        } else if container.contains(.world) {
            let transform = try container.decode(CodableFloat4x4.self, forKey: .world)
            self = .world(transform: transform)
        } else if container.contains(.anchor) {
            let identifier = try container.decode(UUID.self, forKey: .anchor)
            self = .anchor(identifier: identifier)
        } else if container.contains(.plane) {
            let alignments = try container.decode([UInt8].self, forKey: .plane)
            let classifications = try container.decode([UInt64].self, forKey: .plane)
            let minimumBounds = try container.decode(SIMD2<Float>.self, forKey: .plane)
            self = .plane(alignments, classifications: classifications, minimumBounds: minimumBounds)
        } else if container.contains(.image) {
            let group = try container.decode(String.self, forKey: .image)
            let name = try container.decode(String.self, forKey: .image)
            self = .image(group: group, name: name)
        } else if container.contains(.object) {
            let group = try container.decode(String.self, forKey: .object)
            let name = try container.decode(String.self, forKey: .object)
            self = .object(group: group, name: name)
        } else if container.contains(.face) {
            self = .face
        } else if container.contains(.body) {
            self = .body
        } else {
            throw DecodingError.dataCorruptedError(forKey: .camera, in: container, debugDescription: "Invalid Target")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case .camera:
            try container.encode(true, forKey: .camera)
        case .world(let transform):
            try container.encode(transform, forKey: .world)
        case .anchor(let identifier):
            try container.encode(identifier, forKey: .anchor)
        case .plane(let alignment, let classification, let minimumBounds):
            try container.encode(alignment, forKey: .plane)
            try container.encode(classification, forKey: .plane)
            try container.encode(minimumBounds, forKey: .plane)
        case .image(let group, let name):
            try container.encode(group, forKey: .image)
            try container.encode(name, forKey: .image)
        case .object(let group, let name):
            try container.encode(group, forKey: .object)
            try container.encode(name, forKey: .object)
        case .face:
            try container.encode(true, forKey: .face)
        case .body:
            try container.encode(true, forKey: .body)
        }
    }
}

