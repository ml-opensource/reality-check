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
  var content: RealityViewContent!
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
            
            if let root = content.root,
               let selectedEntity = findEntity(root: root, targetID: entitySelection.entityID) {
              await sendMultipeerSelectedRawData(selectedEntity)
            }
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
  
  fileprivate  func sendMultipeerData() async {
    @Dependency(\.multipeerClient) var multipeerClient
    @Dependency(\.realityDump) var realityDump
    
    //TODO: remove reference entity
    //TODO: improve connection state send logic
    // guard case .connected(_) = connectionState else { return }
    
    guard let root = content.root else { return }
    let identifiableEntity = await realityDump.identify(root)
    let realityViewData = try! defaultEncoder.encode(identifiableEntity)
    multipeerClient.send(realityViewData)
    await sendMultipeerSelectedRawData(root)
  }
  
  fileprivate func sendMultipeerSelectedRawData(_ entity: Entity) async {
    @Dependency(\.multipeerClient) var multipeerClient
    let rawData = try! defaultEncoder.encode(String(customDumping: entity))
    multipeerClient.send(rawData)
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
