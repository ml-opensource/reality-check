import RealityKit

public struct AnchoringComponentProperties: ComponentPropertiesRepresentable {
	/// The kind of real world object to which the anchor entity should anchor.
	public let target: CodableTarget
}

public enum CodableTarget: Codable {
	/// The camera.
	case camera

	/// A fixed position in the scene.
	case world(transform: CodableFloat4x4)

	// Coding keys for encoding and decoding
	private enum CodingKeys: String, CodingKey {
		case type
		case transform
	}

	// Coding implementation for encoding and decoding
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		switch self {
		case .camera:
			try container.encode("camera", forKey: .type)
		case .world(let transform):
			try container.encode("world", forKey: .type)
			try container.encode(transform, forKey: .transform)
		}
	}

	public init(_ target: AnchoringComponent.Target) {
		switch target {
		case .camera:
			self = .camera
		case .world(let transform):
			self = .world(transform: CodableFloat4x4(transform))
		@unknown default:
			fatalError()
		}
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let type = try container.decode(String.self, forKey: .type)

		switch type {
		case "camera":
			self = .camera
		case "world":
			let transform = try container.decode(
				CodableFloat4x4.self, forKey: .transform)
			self = .world(transform: transform)
		default:
			throw DecodingError.dataCorruptedError(
				forKey: .type, in: container,
				debugDescription: "Invalid target type")
		}
	}
}
