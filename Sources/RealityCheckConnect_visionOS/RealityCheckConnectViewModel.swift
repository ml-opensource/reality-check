import Dependencies
import Foundation
import Models
import MultipeerClient
import RealityCodable
import RealityDump
import RealityKit
import StreamingClient
import SwiftUI

@Observable
final public class RealityCheckConnectViewModel {
  var connectionState: MultipeerClient.SessionState
  private var scenes: [UInt64: RealityViewContent] = [:]
  var hostName: String
  var isStreaming = false
  var selectedEntityID: UInt64?

  public init(
    connectionState: MultipeerClient.SessionState = .notConnected,
    hostName: String = "..."
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
}

//MARK: - Multipeer
//FIXME: "Extensions must not contain stored properties" error for @Dependency
extension RealityCheckConnectViewModel {
  fileprivate func startMultipeerSession() async {
    @Dependency(\.multipeerClient) var multipeerClient

    /// Setup
    for await action in await multipeerClient.start(
      serviceName: "reality-check",
      sessionType: .peer,
      discoveryInfo: AppInfo.discoveryInfo
    ) {
      switch action {
      case .session(let sessionAction):
        switch sessionAction {
        case .stateDidChange(let state):
          await MainActor.run {
            connectionState = state
          }

          if case .connected = state {
            /// Send Hierarchy
            await sendMultipeerData()
          }

        case .didReceiveData(let data):
          /// Entity selection
          if let entitySelection = try? defaultDecoder.decode(
            EntitySelection.self,
            from: data
          ) {
            selectedEntityID = entitySelection.entityID
            await sendSelectedEntityMultipeerRawData()
          }
        }

      case .browser(_):
        return

      case .advertiser(let advertiserAction):
        switch advertiserAction {
        case .didReceiveInvitationFromPeer(let peer):
          await multipeerClient.acceptInvitation()
          hostName = peer.displayName

          //TODO: Is stopping advertising after connection a desired behavior, or should it be optional?
          await multipeerClient.stopAdvertisingPeer()
        }
      }
    }
  }

  fileprivate func sendMultipeerData() async {
    @Dependency(\.multipeerClient) var multipeerClient

    guard case .connected = connectionState else { return }

    //TODO: remove/hide reference entity

    var entities: [RealityPlatform.visionOS.EntityType] = []

    for content in scenes.values {
      guard let root = content.root else { return }
      entities.append(await root.encoded)
    }

    let realityViewData = try! defaultEncoder.encode(
      RealityPlatform.visionOS.Scene(children: entities))
    multipeerClient.send(realityViewData)

    // TODO: set default selection?
    // if selectedEntityID == nil {
    //   await sendSelectedEntityMultipeerRawData()
    // }
  }

  fileprivate func sendSelectedEntityMultipeerRawData() async {
    @Dependency(\.multipeerClient) var multipeerClient

    guard let selectedEntityID else { return }

    for scene in scenes.values {
      guard let root = scene.root else { return }

      //FIXME: seems to be a new find by ID method in visionOS
      if let selectedEntity = findEntity(root: root, targetID: selectedEntityID) {
        let rawData = try! defaultEncoder.encode(String(customDumping: selectedEntity))
        multipeerClient.send(rawData)
      }
    }
  }
}

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
