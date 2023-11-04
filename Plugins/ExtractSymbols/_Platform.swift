import Foundation

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

  var extractedDirectory: String {
    switch self {
      case .iOS:
        return "Sources/RealitySymbols/Extracted/iOS"
      case .macOS:
        return "Sources/RealitySymbols/Extracted/macOS"
      case .visionOS:
        return "Sources/RealitySymbols/Extracted/visionOS"
    }
  }

  var processedDirectory: String {
    switch self {
      case .iOS:
        return "Sources/RealitySymbols/Processed/iOS"
      case .macOS:
        return "Sources/RealitySymbols/Processed/macOS"
      case .visionOS:
        return "Sources/RealitySymbols/Processed/visionOS"
    }
  }

  var modelsDirectory: String {
    "Sources/Models/autogenerated"
  }
}