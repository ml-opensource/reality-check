import Foundation

public struct PhysicsMotionComponentProperties: ComponentPropertiesRepresentable {
	/// The linear velocity of the body in the physics simulation.
	public let linearVelocity: SIMD3<Float>

	/// The angular velocity of the body around the center of mass.
	public let angularVelocity: SIMD3<Float>
}
