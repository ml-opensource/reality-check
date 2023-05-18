import Foundation

public struct PointLightComponentProperties: ComponentPropertiesRepresentable {
	/// The intensity of the point light, measured in lumen.
	public let intensity: Float

	/// The point light attenuation radius in meters.
	///
	/// At any distance greater from the light that's greater than this value, the light's
	/// intensity is zero.
	public let attenuationRadius: Float
}
