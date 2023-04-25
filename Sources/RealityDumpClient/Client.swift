import Dependencies
import RealityKit

public struct RealityDump {
    public func raw(
        _ loadedEntity: Entity,
        printing: Bool = true,
        detail: Int = 1,
        org: Bool = true
    ) async -> [String] {
        await self.raw(loadedEntity, printing, detail, org)
    }

    var raw: (Entity, Bool, Int, Bool) async -> [String]

    public func identify(
        _ loadedEntity: Entity,
        detail: Int = 1
    ) async -> [IdentifiableEntity] {
        await self.identify(loadedEntity, detail)
    }

    var identify: (Entity, Int) async -> [IdentifiableEntity]
}

extension DependencyValues {
    public var realityDump: RealityDump {
        get { self[RealityDump.self] }
        set { self[RealityDump.self] = newValue }
    }
}
