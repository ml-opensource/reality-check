import RealityKit

public struct ModelComponentProperties: ComponentPropertiesRepresentable {
	/// The mesh that defines the shape of the entity.
	///
	/// For more information, see ``RealityKit/MeshResource``
	public let mesh: CodableMeshResource

	/// The materials used by the model.
	///
	/// Each ``RealityKit/MeshResource`` requires a set of materials. An entity that has no materials
	/// renders using a pink, striped material.  To determine the number of  materials a model entity requires
	/// , use `MeshResource.expectedMaterialCount`
	public let materials: [CodableMaterial]

	/// A margin applied to an entity’s bounding box that determines object
	/// visibility.
	///
	/// When determining which entities are currently visible, RealityKit tests
	/// each entity’s bounding box to see if it overlaps with the camera’s field
	/// of view (also known as the camera’s _frustum_). For efficiency, entities
	/// with a bounding box that don’t overlap the camera’s frustum aren’t
	/// rendered. Use this property to prevent RealityKit from incorrectly
	/// culling entities that use a ``CustomMaterial`` with a geometry modifier
	/// that moves vertices outside of the entity’s bounding box.
	///
	/// RealityKit adds the value of `boundsMargin` to the bounding box before
	/// determining which entities are visible.
	public let boundsMargin: Float
}

public struct CodableMaterial: Codable {
	public init(_ material: RealityKit.Material) {
		//TODO: switch/cast on different materials
	}
}

public struct CodableMeshResource: Codable {

	/// The number of material entries required to render the mesh resource.
	public var expectedMaterialCount: Int

	/// A box that bounds the mesh.
	public var bounds: CodableBoundingBox

	public init(_ meshResource: RealityKit.MeshResource) {
		self.expectedMaterialCount = meshResource.expectedMaterialCount
		self.bounds = CodableBoundingBox(meshResource.bounds)
	}
}

public struct CodableBoundingBox: Codable {
	/// The position of the minimum corner of the box.
	public var min: SIMD3<Float>

	/// The position of the maximum corner of the box.
	public var max: SIMD3<Float>

	public init(_ boundingBox: RealityKit.BoundingBox) {
		self.init(
			min: boundingBox.min,
			max: boundingBox.max
		)
	}

	public init(min: SIMD3<Float>, max: SIMD3<Float>) {
		self.min = min
		self.max = max
	}

	private enum CodingKeys: String, CodingKey {
		case min
		case max
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(min, forKey: .min)
		try container.encode(max, forKey: .max)
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		min = try container.decode(SIMD3<Float>.self, forKey: .min)
		max = try container.decode(SIMD3<Float>.self, forKey: .max)
	}
}
