import RealityKit

public struct SynchronizationComponentProperties: ComponentPropertiesRepresentable {
	/// A unique identifier of an entity within a network session.
	public let identifier: UInt64

	/// A Boolean that indicates whether the calling process owns the entity.
	public let isOwner: Bool

	/// The entity’s transfer ownership mode.
	///
	/// By default, the transfer mode is
	/// ``SynchronizationComponent/OwnershipTransferMode-swift.enum/autoAccept``.
	/// You can set it to
	/// ``SynchronizationComponent/OwnershipTransferMode-swift.enum/manual`` to
	/// require explicit confirmation of the request by your app.
	public let ownershipTransferMode: CodableOwnershipTransferMode
}

public enum CodableOwnershipTransferMode: Codable {
	case autoAccept
	case manual

	public init(_ ownershipTransferMode: SynchronizationComponent.OwnershipTransferMode) {
		switch ownershipTransferMode {
		case .autoAccept:
			self = .autoAccept
		case .manual:
			self = .manual
		@unknown default:
			fatalError()
		}
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let stringValue = try container.decode(String.self)

		switch stringValue {
		case "autoAccept":
			self = .autoAccept
		case "manual":
			self = .manual
		default:
			throw DecodingError.dataCorruptedError(
				in: container, debugDescription: "Invalid ownership transfer mode")
		}
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()

		switch self {
		case .autoAccept:
			try container.encode("autoAccept")
		case .manual:
			try container.encode("manual")
		}
	}
}
