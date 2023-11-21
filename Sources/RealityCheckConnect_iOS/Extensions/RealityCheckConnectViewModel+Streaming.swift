import Foundation

extension RealityCheckConnectViewModel {

  func startVideoStreaming() async {
    await MainActor.run {
      isStreaming = true
    }

    for await frameData in await streamingClient.startScreenCapture() {
      await multipeerClient.send(frameData)
    }
  }

  func stopVideoStreaming() async {
    await MainActor.run {
      isStreaming = false
    }

    streamingClient.stopScreenCapture()
  }
}
