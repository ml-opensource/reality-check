import RealityKit

public struct ModelDebugOptionsComponentProperties: ComponentPropertiesRepresentable {
	/// The part of the rendering process to display as the entity’s surface
	/// texture.
	public let visualizationMode: ModelDebugOptionsComponent.VisualizationMode
}

extension ModelDebugOptionsComponent.VisualizationMode: Codable {}
