import Dependencies
import RealityCodable
import RealityKit

public struct RealityDump {

  //  @discardableResult
  //  /// Uses PointFree `custom-dump` to represent textually an `Entity`
  //  /// - Parameters:
  //  ///   - entity: The entity to instrospect
  //  ///   - printing: Optionally display on console
  //  /// - Returns: A structured string
  //  public func dump(
  //    _ entity: Entity,
  //    printing: Bool = true
  //  ) async -> String {
  //    await self.dump(entity, printing)
  //  }
  //
  //  var dump: (Entity, Bool) async -> String

  public func identify(
    _ entity: Entity,
    detail: Int = 1
  ) async -> _CodableEntity {
    await self.identify(entity, detail)
  }

  var identify: (Entity, Int) async -> _CodableEntity
}

extension DependencyValues {
  public var realityDump: RealityDump {
    get { self[RealityDump.self] }
    set { self[RealityDump.self] = newValue }
  }
}
