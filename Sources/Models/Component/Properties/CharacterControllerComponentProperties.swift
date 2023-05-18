import RealityKit

public struct CharacterControllerComponentProperties: ComponentPropertiesRepresentable {
	/// The capsule radius.
	///
	/// Specify this value in the entity's coordinate system.
	public let radius: Float

	/// The capsule height.
	///
	/// The capsule height includes radii and should be specified the entity's coordinate system.
	public let height: Float

	/// An added tolerance around the character capsule.
	///
	/// A small skin, known as the *contact offset*, is maintained around the controller's volume to avoid
	/// rounding and precision issues with collision detection. Specify this value relative to the entity's
	/// coordinate system.
	public let skinWidth: Float

	/// The slope limit expressed as a limit angle in radians.
	///
	/// This value represents the maximum slope that the character can move over. RealityKit applies this value
	/// to characters that are walking on static objects, but not when walking on kinematic or dynamic objects.
	public let slopeLimit: Float

	/// The maximum obstacle height that the controller can move over.
	///
	/// Specify this value relative to the entity's coordinate system.
	public let stepLimit: Float

	/// Y axis direction relative to the physics origin.
	///
	/// Rotates the object so that the vertical height is along the up vector.
	/// Vector must be normalized and specified in *physics space*, the coordinate system of the
	/// physics simulation.
	public let upVector: SIMD3<Float>

	/// The character's collision filter.
	///
	/// For more information on using collision filters, see <doc://com.apple.documentation/realitykit/controlling-entity-collisions-in-realitykit/>.
	public let collisionFilter: CodableCollisionFilter
}
