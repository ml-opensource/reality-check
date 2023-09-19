import Dependencies
import Foundation
import Models
import MultipeerClient
import RealityKit
import SwiftUI
import StreamingClient
import RealityDump
import RealityDumpClient

@Observable
final public class RealityCheckConnectViewModel {
  var connectionState: MultipeerClient.SessionState
  var scenes: [UInt64: RealityViewContent] = [:]
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
    scenes.updateValue(content, forKey: scene.id)
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
          multipeerClient.acceptInvitation()
          multipeerClient.stopAdvertisingPeer()
          await MainActor.run {
            hostName = peer.displayName
          }
        }
      }
    }
  }
  
  fileprivate func sendMultipeerData() async {
    @Dependency(\.multipeerClient) var multipeerClient
    @Dependency(\.realityDump) var realityDump
    
    guard case .connected = connectionState else { return }
        
    //TODO: remove/hide reference entity
    
    //FIXME: improve naming, on visionOS first level children are not anchors
    var identifiableAnchors: [IdentifiableEntity] = []

    for scene in scenes.values {
      guard let root = scene.root else { return }
      identifiableAnchors.append(await realityDump.identify(root))
    }
    
    let realityViewData = try! defaultEncoder.encode(CodableScene(anchors: identifiableAnchors))
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
