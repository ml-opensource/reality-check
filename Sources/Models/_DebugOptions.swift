import Foundation

//Needed because macOS doesn't have all the values available.
public struct _DebugOptions: OptionSet, Codable, Equatable {
  public let rawValue: Int

  static public let none = _DebugOptions([])
  static public let showAnchorGeometry = _DebugOptions(rawValue: 1 << 4)  // 16
  static public let showAnchorOrigins = _DebugOptions(rawValue: 1 << 3)  // 8
  static public let showFeaturePoints = _DebugOptions(rawValue: 1 << 5)  // 32
  static public let showPhysics = _DebugOptions(rawValue: 1 << 0)  // 1
  static public let showSceneUnderstanding = _DebugOptions(rawValue: 1 << 6)  // 64
  static public let showStatistics = _DebugOptions(rawValue: 1 << 1)  // 2
  static public let showWorldOrigin = _DebugOptions(rawValue: 1 << 2)  // 4

  public init(
    rawValue: Int
  ) {
    self.rawValue = rawValue
  }
}
