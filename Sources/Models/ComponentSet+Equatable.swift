import RealityKit

extension Entity.ComponentSet: Equatable {
  //FIXME: Find a better way to use equatable or use another type instear `Entity.ComponentSet`

  public static func == (lhs: Entity.ComponentSet, rhs: Entity.ComponentSet) -> Bool {
    lhs.count == rhs.count
  }
}
