import Foundation
@_implementationOnly import MultipeerClient

#if os(iOS)
  import DeviceKit
#endif

struct AppInfo {
  static var appName: String? {
    readFromInfoPlist(withKey: "CFBundleName")
  }

  static var version: String? {
    readFromInfoPlist(withKey: "CFBundleShortVersionString")
  }

  static var build: String? {
    readFromInfoPlist(withKey: "CFBundleVersion")
  }

  static var minimumOSVersion: String? {
    readFromInfoPlist(withKey: "MinimumOSVersion")
  }

  static var copyrightNotice: String? {
    readFromInfoPlist(withKey: "NSHumanReadableCopyright")
  }

  static var bundleIdentifier: String? {
    readFromInfoPlist(withKey: "CFBundleIdentifier")
  }

  // lets hold a reference to the Info.plist of the app as Dictionary
  static private let infoPlistDictionary = Bundle.main.infoDictionary

  /// Retrieves and returns associated values (of Type String) from info.Plist of the app.
  static private func readFromInfoPlist(withKey key: String) -> String? {
    infoPlistDictionary?[key] as? String
  }
}

extension AppInfo {
  static var discoveryInfo: DiscoveryInfo {
    var appVersion: String?
    if let version = AppInfo.version,
      let build = AppInfo.build
    {
      appVersion = "\(version) (\(build))"
    }

    var system: String?
    if let systemName = Device.current.systemName,
      let systemVersion = Device.current.systemVersion
    {
      system = "\(systemName) \(systemVersion)"
    }

    return DiscoveryInfo(
      appName: AppInfo.appName,
      appVersion: appVersion,
      device: Device.current.safeDescription,
      system: system
    )
  }
}
