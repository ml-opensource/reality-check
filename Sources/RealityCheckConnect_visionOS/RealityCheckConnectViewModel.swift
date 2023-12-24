import Dependencies
import Foundation
import Models
import MultipeerClient
import RealityKit
import SwiftUI

@Observable
final public class RealityCheckConnectViewModel {
  var connectionState: MultipeerClient.SessionState
  var scenes: [UInt64: RealityViewContent] = [:]
  var hostName: String
  var isStreaming = false
  var selectedEntityID: UInt64?

  @ObservationIgnored
  var debouncedUpdateContentTask: Task<Void, Error>?

  @ObservationIgnored
  @Dependency(\.multipeerClient) var multipeerClient

  @ObservationIgnored
  @Dependency(\.streamingClient) var streamingClient

  public init(
    connectionState: MultipeerClient.SessionState = .notConnected,
    hostName: String = "[REDACTED]"
  ) {
    self.connectionState = connectionState
    self.hostName = hostName

    Task(priority: .userInitiated) {
      do {
        try await startMultipeerSession()
      }
    }
  }

  func updateContent(_ content: RealityViewContent) {
    guard let scene = content.root?.scene else { return }
    _scenes.updateValue(content, forKey: scene.id)

    Task {
      await sendMultipeerData()
    }
  }

  func addScene(_ content: RealityViewContent) {
    guard let scene = content.root?.scene else { return }
    _scenes.updateValue(content, forKey: scene.id)

//    Task {
//      await sendMultipeerData()
//    }
  }

  func removeScene(_ content: RealityViewContent) {
    guard let scene = content.root?.scene else { return }
    _scenes.removeValue(forKey: scene.id)

//    Task {
//      await sendMultipeerData()
//    }
  }
}
