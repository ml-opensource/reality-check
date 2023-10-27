import Foundation

public struct DirectionalLightShadowComponentProperties: ComponentPropertiesRepresentable {
	/// The depth bias for the shadow.
	public let depthBias: Float

	/// The maximum distance for the shadow.
	public let maximumDistance: Float
}
