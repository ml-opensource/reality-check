import Foundation

public struct DiscoveryInfo: Equatable {
  public enum Key: String {
    case appName = "AppNameKey"
    case appVersion = "AppVersionKey"
    case device = "DeviceKey"
    case system = "SystemKey"
  }

  public let appName: String?
  public let appVersion: String?
  public let device: String
  public let system: String?

  public init(
    appName: String?,
    appVersion: String?,
    device: String,
    system: String?
  ) {
    self.appName = appName
    self.appVersion = appVersion
    self.device = device
    self.system = system
  }

  public init?(
    rawValue: [String: String]?
  ) {
    guard let rawValue else { return nil }
    self.appName = rawValue[Key.appName.rawValue]
    self.appVersion = rawValue[Key.appVersion.rawValue]
    self.device = rawValue[Key.device.rawValue] ?? "@unknown"
    self.system = rawValue[Key.system.rawValue]
  }

  public var rawValue: [String: String] {
    var info: [String: String] = [:]
    if let appName {
      info[Key.appName.rawValue] = appName
    }
    if let appVersion {
      info[Key.appVersion.rawValue] = appVersion
    }
    info[Key.device.rawValue] = device
    if let system {
      info[Key.system.rawValue] = system
    }
    return info
  }
}
