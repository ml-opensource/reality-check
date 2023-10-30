import Foundation
import PackagePlugin

@main
struct ExtractSymbols: CommandPlugin {

  enum _Platform: CaseIterable {
    case iOS
    case macOS
    case visionOS

    var target: String {
      switch self {
        case .iOS:
          return "arm64-apple-ios"
        case .macOS:
          return "arm64-apple-macos"
        case .visionOS:
          return "arm64-apple-xros"
      }
    }

    var outputDirectory: String {
      switch self {
        case .iOS:
          return "Sources/RealitySymbols/Extracted/iOS"
        case .macOS:
          return "Sources/RealitySymbols/Extracted/macOS"
        case .visionOS:
          return "Sources/RealitySymbols/Extracted/visionOS"
      }
    }

    var sdk: String {
      switch self {
        case .iOS:
          return "Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk"
        case .macOS:
          return "Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"
        case .visionOS:
          return "Platforms/XROS.platform/Developer/SDKs/XROS.sdk"
      }
    }
  }

  func performCommand(context: PackagePlugin.PluginContext, arguments: [String]) async throws {
    let xcodeSelect = Process()
    let pipe = Pipe()
    xcodeSelect.launchPath = "/usr/bin/env"
    xcodeSelect.arguments = ["xcode-select", "-p"]
    xcodeSelect.standardOutput = pipe
    try xcodeSelect.run()
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let xcodePath = String(data: data, encoding: .utf8)?
      .trimmingCharacters(in: .whitespacesAndNewlines)
    xcodeSelect.waitUntilExit()

    for platform in _Platform.allCases {
      let symbolgraphExtract = Process()
      symbolgraphExtract.launchPath = "/usr/bin/env"
      // TODO: verify use case of `launchPath` vs `executableURL`
      // symbolgraphExtract.executableURL = URL(fileURLWithPath: "/usr/bin/swift")
      symbolgraphExtract.arguments = [
        "swift",
        "symbolgraph-extract",
        "-module-name",
        "RealityFoundation",
        "-target",
        "\(platform.target)",
        "-output-dir",
        "\(symbolgraphExtract.currentDirectoryURL!.path() + platform.outputDirectory)",
        "-sdk",
        "\(xcodePath!)/\(platform.sdk)",
      ]
      try symbolgraphExtract.run()
      symbolgraphExtract.waitUntilExit()
      
      print(
        symbolgraphExtract.launchPath!,
        symbolgraphExtract.arguments!.joined(separator: " ")
      )
    }
  }
}
