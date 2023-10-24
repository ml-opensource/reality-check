import Dependencies
import Foundation
import StreamingClient

//MARK: - Video streaming
//FIXME: "Extensions must not contain stored properties" error for @Dependency
extension RealityCheckConnectViewModel {
  public func startVideoStreaming() async {
    @Dependency(\.multipeerClient) var multipeerClient
    @Dependency(\.streamingClient) var streamingClient

    await MainActor.run {
      isStreaming = true
    }

    for await frameData in await streamingClient.startScreenCapture() {
      multipeerClient.send(frameData)
    }
  }

  func stopVideoStreaming() async {
    @Dependency(\.streamingClient) var streamingClient

    await MainActor.run {
      isStreaming = false
    }

    streamingClient.stopScreenCapture()
  }
}
