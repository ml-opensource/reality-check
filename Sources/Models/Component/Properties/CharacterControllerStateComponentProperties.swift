import RealityKit

public struct CharacterControllerStateComponentProperties: ComponentPropertiesRepresentable {
	/// The linear speed relative to the phyics origin. In physics space.
	public let velocity: SIMD3<Float>

	/// True if character controller is grounded, otherwise false.
	public let isOnGround: Bool
}
