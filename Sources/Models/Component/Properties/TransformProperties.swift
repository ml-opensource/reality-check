import Foundation
import simd

public struct TransformProperties: ComponentPropertiesRepresentable, Codable {
	/// The scaling factor applied to the entity.
	public let scale: SIMD3<Float>

	/// The rotation of the entity specified as a unit quaternion.
	public let rotation: CodableQuaternion
	/// The position of the entity along the x, y, and z axes.
	public let translation: SIMD3<Float>

	/// The transform represented as a 4x4 matrix.
	///
	/// The ``Transform`` component can’t represent all transforms that a
	/// general 4x4 matrix can represent. Using a 4x4 matrix to set the
	/// transform is therefore a lossy event that might result in certain
	/// transformations, like shear, being dropped.
	public let matrix: CodableFloat4x4

	private enum CodingKeys: String, CodingKey {
		case scale
		case rotation
		case translation
		case matrix
	}

	public init(
		scale: SIMD3<Float>,
		rotation: CodableQuaternion,
		translation: SIMD3<Float>,
		matrix: CodableFloat4x4
	) {
		self.scale = scale
		self.rotation = rotation
		self.translation = translation
		self.matrix = matrix
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		scale = try container.decode(SIMD3<Float>.self, forKey: .scale)
		rotation = try container.decode(CodableQuaternion.self, forKey: .rotation)
		translation = try container.decode(SIMD3<Float>.self, forKey: .translation)
		matrix = try container.decode(CodableFloat4x4.self, forKey: .matrix)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(scale, forKey: .scale)
		try container.encode(rotation, forKey: .rotation)
		try container.encode(translation, forKey: .translation)
		try container.encode(matrix, forKey: .matrix)
	}
}
