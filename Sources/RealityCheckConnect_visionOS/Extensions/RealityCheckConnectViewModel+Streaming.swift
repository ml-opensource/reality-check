import Dependencies
import Foundation
import StreamingClient

//MARK: - Video streaming
extension RealityCheckConnectViewModel {
  public func startVideoStreaming() async {
    await MainActor.run {
      isStreaming = true
    }

    for await frameData in await streamingClient.startScreenCapture() {
      multipeerClient.send(frameData)
    }
  }

  func stopVideoStreaming() async {
    await MainActor.run {
      isStreaming = false
    }

    streamingClient.stopScreenCapture()
  }
}
