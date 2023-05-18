import RealityKit

public struct CodableCollisionFilter: Codable {
	public var rawValue: RealityKit.CollisionFilter {
		.init(
			group: self.group.collisionGroup,
			mask: self.mask.collisionGroup
		)
	}
	public var group: CodableCollisionGroup
	public var mask: CodableCollisionGroup

	init(_ collisionFilter: RealityKit.CollisionFilter) {
		self.group = CodableCollisionGroup(collisionFilter.group)
		self.mask = CodableCollisionGroup(collisionFilter.mask)
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.group = try container.decode(CodableCollisionGroup.self, forKey: .group)
		self.mask = try container.decode(CodableCollisionGroup.self, forKey: .mask)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(group, forKey: .group)
		try container.encode(mask, forKey: .mask)
	}

	private enum CodingKeys: String, CodingKey {
		case group
		case mask
	}
}

public struct CodableCollisionGroup: Codable {
	public let collisionGroup: RealityKit.CollisionGroup

	public init(_ collisionGroup: RealityKit.CollisionGroup) {
		self.collisionGroup = collisionGroup
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let rawValue = try container.decode(UInt32.self)
		self.collisionGroup = CollisionGroup(rawValue: rawValue)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(collisionGroup.rawValue)
	}
}
