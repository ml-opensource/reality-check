import Foundation
import MultipeerClient

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

    //FIXME: find a way to get the system version
    system = "visionOS 1.0"

    //FIXME: find a way to get the device name
    let device = " Vision Pro"

    return DiscoveryInfo(
      appName: AppInfo.appName,
      appVersion: appVersion,
      device: device,
      system: system
    )
  }
}
