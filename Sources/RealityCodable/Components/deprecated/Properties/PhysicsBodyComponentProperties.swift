import RealityKit

public struct PhysicsBodyComponentProperties: ComponentPropertiesRepresentable {
	/// The physics body’s mode, indicating how or if it moves.
	///
	/// By default, this value is set to ``PhysicsBodyMode/dynamic``, meaning
	/// the body responds to forces.
	public let mode: CodablePhysicsBodyMode

	/// The physics body’s mass properties, like inertia and center of mass.
	///
	/// By default, the mass properties value is
	/// ``PhysicsMassProperties/default``, which matches the properties of a
	/// unit sphere with mass of 1 kilogram.
	//FIXME: public let massProperties: PhysicsMassProperties

	/// The physics body’s material properties, like friction.
	///
	/// By default, the body’s material resource is set to
	/// ``PhysicsMaterialResource/default``, which provides a modest amount of
	/// friction and restitution (bounciness).
	//FIXME: public let material: PhysicsMaterialResource

	/// A tuple of Boolean values that you use to lock the position of the
	/// physics body along any of the three axes.
	///
	/// You can restrict movement of the body along one or more axes by setting
	/// the corresponding item in the tuple to `true`. For example, if you set
	/// the `x` and the `z` items in the tuple to `true`, then the body can move
	/// only along the y-axis. By default, movement isn’t restricted.
	public let isTranslationLocked: MovementLock

	/// A tuple of Boolean values that you use to lock rotation of the physics
	/// body around any of the three axes.
	///
	/// For any one of the three Booleans in the tuple that you set to `true`,
	/// rotation is restricted on the axis represented by that item. For
	/// example, if you set the `x` item to true, then the body can’t rotate
	/// around the x-axis. By default, rotation isn’t restricted.
	public let isRotationLocked: MovementLock

	/// A Boolean that controls whether the physics simulation performs
	/// continuous collision detection.
	///
	/// Set the value to `true` to perform continuous collision detection. The
	/// value is `false` by default, indicating the simulation should apply
	/// discrete collision detection.
	///
	/// Discrete collision detection considers only the position of a body once
	/// per rendered frame, or about every 16 milliseconds at 60 frames per
	/// second. Continuous collision detection considers the position of the
	/// body throughout the frame interval. The latter is more computationally
	/// expensive, but can help to avoid missing a collision for a quickly
	/// moving object, like a projectile.
	public let isContinuousCollisionDetectionEnabled: Bool
}

public enum CodablePhysicsBodyMode: Codable {
	case `static`
	case kinematic
	case dynamic

	public init(_ physicsBodyMode: PhysicsBodyMode) {
		switch physicsBodyMode {
		case .static:
			self = .static
		case .kinematic:
			self = .kinematic
		case .dynamic:
			self = .dynamic
		@unknown default:
			fatalError()
		}
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let stringValue = try container.decode(String.self)

		switch stringValue {
		case "static":
			self = .static
		case "kinematic":
			self = .kinematic
		case "dynamic":
			self = .dynamic
		default:
			throw DecodingError.dataCorruptedError(
				in: container, debugDescription: "Invalid physics body mode")
		}
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()

		switch self {
		case .static:
			try container.encode("static")
		case .kinematic:
			try container.encode("kinematic")
		case .dynamic:
			try container.encode("dynamic")
		}
	}
}

public struct MovementLock: Codable {
	public let x: Bool
	public let y: Bool
	public let z: Bool

	public init(_ tuple: (x: Bool, y: Bool, z: Bool)) {
		self.x = tuple.0
		self.y = tuple.1
		self.z = tuple.2
	}
}
