import RealityKit

public struct CollisionComponentProperties: ComponentPropertiesRepresentable {
	/// A collection of shape resources that collectively represent the outer
	/// dimensions of an entity for the purposes of collision detection.
	public let shapes: [CodableShapeResource]

	/// The collision mode.
	public let mode: CodableCollisionComponentMode

	/// The collision filter used to segregate entities into different collision
	/// groups.
	public let filter: CodableCollisionFilter
}

public struct CodableShapeResource: Codable {
	public init(_ hapeResource: RealityKit.ShapeResource) {
		//TODO: switch/cast on different materials
	}
}

public enum CodableCollisionComponentMode: Codable {
	case `default`
	case trigger

	init(_ collisionComponentMode: RealityKit.CollisionComponent.Mode) {
		switch collisionComponentMode {
		case .default:
			self = .default
		case .trigger:
			self = .trigger
		@unknown default:
			fatalError()
		}
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let rawValue = try container.decode(String.self)

		switch rawValue {
		case "default":
			self = .default
		case "trigger":
			self = .trigger
		default:
			throw DecodingError.dataCorruptedError(
				in: container, debugDescription: "Invalid mode value: \(rawValue)")
		}
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()

		switch self {
		case .default:
			try container.encode("default")
		case .trigger:
			try container.encode("trigger")
		}
	}
}
