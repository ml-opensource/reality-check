import Foundation

public struct SpotLightComponentProperties: ComponentPropertiesRepresentable {
	/// The intensity of the spotlight measured in lumen.
	public let intensity: Float

	/// The inner angle of the spotlight in degrees.
	///
	/// A spot light's `innerAngle` and `outerAngle` reflect the size of the light's cone, which shines
	/// relative to the entity's forward direction (0, 0, -1). The light is at full  intensity between 0° and
	/// `innerAngle`. RealityKit attenuates the  light's intensity between `innerAngle` and
	/// `outerAngle`.  Beyond `outerAngle`, the light intensity is `0.0`.
	public let innerAngleInDegrees: Float

	/// The outer angle of the spotlight in degrees.
	///
	/// A spot light's `innerAngle` and `outerAngle` reflect the size of the light's cone, which shines
	/// relative to the entity's forward direction (0, 0, -1). The light is at full  intensity between 0° and
	/// `innerAngle`. RealityKit attenuates the  light's intensity between `innerAngle` and
	/// `outerAngle`.  Beyond `outerAngle`, the light intensity is `0.0`.
	public let outerAngleInDegrees: Float

	/// The attenuation radius in meters, after which the intensity of the
	/// spotlight is zero.
	public let attenuationRadius: Float
}
