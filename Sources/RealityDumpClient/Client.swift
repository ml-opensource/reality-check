import Dependencies
import RealityCodable
import RealityKit

public struct RealityDump {
  public func identify(
    _ entity: Entity
  ) async -> CodableEntity {
    await self.identify(entity)
  }

  var identify: (Entity) async -> CodableEntity
}

extension DependencyValues {
  public var realityDump: RealityDump {
    get { self[RealityDump.self] }
    set { self[RealityDump.self] = newValue }
  }
}
