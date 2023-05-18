import Foundation

public struct DirectionalLightComponentProperties: ComponentPropertiesRepresentable {
	/// The intensity of the directional light, measured in lumen per square
	/// meter.
	public let intensity: Float

	/// A Boolean that you use to control whether the directional light operates
	/// as a proxy for a real-world light.
	///
	/// Set the value to `true` when you want the light to cast shadows on
	/// virtual content without illuminating anything in the scene. You can use
	/// this to create shadows on occlusion materials that accept dynamic
	/// lighting.
	public let isRealWorldProxy: Bool
}
