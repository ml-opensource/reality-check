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

  public init(
    connectionState: MultipeerClient.SessionState = .notConnected,
    hostName: String = "[REDACTED]"
  ) {
    self.connectionState = connectionState
    self.hostName = hostName

    Task(priority: .userInitiated) {
      await startMultipeerSession()
    }
  }

  func updateContent(_ content: RealityViewContent) {
    guard let scene = content.root?.scene else { return }
    _scenes.updateValue(content, forKey: scene.id)

    //FIXME: Implement with cancellation or debounce to avoid excessive roundtrips
    Task {
      await sendMultipeerData()
    }
  }

  func addScene(_ content: RealityViewContent) {
    guard let scene = content.root?.scene else { return }
    _scenes.updateValue(content, forKey: scene.id)

    //FIXME: Implement with cancellation or debounce to avoid excessive roundtrips
    Task {
      await sendMultipeerData()
    }
  }
  
  func removeScene(_ content: RealityViewContent) {
    guard let scene = content.root?.scene else { return }
    _scenes.removeValue(forKey: scene.id)

    //FIXME: Implement with cancellation or debounce to avoid excessive roundtrips
    Task {
      await sendMultipeerData()
    }
  }

}
