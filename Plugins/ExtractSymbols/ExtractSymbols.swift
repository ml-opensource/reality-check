import Foundation
import PackagePlugin

@main
struct ExtractSymbols: CommandPlugin {
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

    let symbolgraphExtract = Process()
    symbolgraphExtract.executableURL = URL(fileURLWithPath: "/usr/bin/swift")
    symbolgraphExtract.arguments = [
      "symbolgraph-extract",
      "-module-name",
      "RealityFoundation",
      "-target",
      "arm64-apple-ios",
      "-output-dir",
      "\(symbolgraphExtract.currentDirectoryURL!.path(percentEncoded: false))Sources/RealitySymbols/Bla",
      "-sdk",
      "\(xcodePath!)/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk",
    ]
    try symbolgraphExtract.run()

    print(
      symbolgraphExtract.executableURL!.path,
      symbolgraphExtract.arguments!.joined(separator: " ")
    )


    // process.waitUntilExit()

    // let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
    // let output = String(decoding: outputData, as: UTF8.self)
    // print(output)

    // let contributors = Set(output.components(separatedBy: CharacterSet.newlines)).sorted()
    //   .filter { !$0.isEmpty }
    // try contributors.joined(separator: "\n")
    //   .write(toFile: "Sources/RealitySymbols/CONTRIBUTORS.txt", atomically: true, encoding: .utf8)
  }
}
