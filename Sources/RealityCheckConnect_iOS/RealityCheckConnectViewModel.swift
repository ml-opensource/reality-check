import Dependencies
import Models
import MultipeerClient
import RealityCodable
import RealityDump
import RealityKit
import StreamingClient
import SwiftUI

final class RealityCheckConnectViewModel: ObservableObject {
  var connectionState: MultipeerClient.SessionState
  var hostName: String
  var isStreaming = false

  @Dependency(\.multipeerClient) var multipeerClient
  @Dependency(\.streamingClient) var streamingClient

  var arView: ARView?
  private var selectionEntity = ModelEntity(
    mesh: .generateSphere(radius: 0.075),
    materials: [UnlitMaterial(color: .systemPink)]
  )

  init(
    connectionState: MultipeerClient.SessionState = .notConnected,
    hostName: String = "...",
    arView: ARView? = nil
  ) {
    self.connectionState = connectionState
    self.hostName = hostName
    self.arView = arView
    Task {
      await startMultipeerSession()
    }
  }
}

//MARK: - Multipeer
extension RealityCheckConnectViewModel {
  func startMultipeerSession() async {
    //MARK: Setup
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
                //MARK: Send Hierarchy
                await sendMultipeerData()
              }

            case .didReceiveData(let data):
              //ARView Debug Options
              if let debugOptions = try? JSONDecoder()
                .decode(
                  _DebugOptions.self,
                  from: data
                )
              {
                await MainActor.run {
                  arView?.debugOptions = ARView.DebugOptions(
                    rawValue: debugOptions.rawValue
                  )
                }
              }
          //MARK: Entity selection
          //FIXME:
          // else if let entitySelection = try? defaultDecoder.decode(
          //   EntitySelection.self,
          //   from: data
          // ) {
          //   if let entity = await arView?
          //     .findEntityIdentified(targetID: entitySelection.entityID)
          //   {
          //     await MainActor.run {
          //       let parentBounds = entity.visualBounds(relativeTo: nil)
          //       selectionEntity.setParent(entity)
          //       // selectionEntity.setPosition(parentBounds.center, relativeTo: nil)
          //       // selectionEntity.position.y = parentBounds.extents.y
          //     }
          //   }
          // } else {
          //   fatalError()
          // }
          }

        case .browser(_):
          return

        case .advertiser(let advertiserAction):
          switch advertiserAction {
            case .didReceiveInvitationFromPeer(let peer):
              await multipeerClient.acceptInvitation()
              hostName = peer.displayName
          }
      }
    }
  }

  func sendMultipeerData() async {
    guard let arView else {
      //FIXME: make a runtime error instead
      fatalError("ARView is required in order to be able to send its hierarchy")
    }

    let anchors = await arView.scene.anchors.compactMap { $0 }
    var anchorsEncoded: [RealityPlatform.iOS.EntityType] = []
    var rawDump: [String] = []
    for anchor in anchors {
     //FIXME: rawDump.append(String(customDumping: anchor))
      anchorsEncoded.append(await anchor.encoded)
    }

    let rawData = try! defaultEncoder.encode(rawDump.reduce("", +))
    multipeerClient.send(rawData)

    let arViewData = try! await defaultEncoder.encode(
      CodableARView(
        arView,
        anchors: anchorsEncoded,
        contentScaleFactor: arView.contentScaleFactor
      )
    )
    multipeerClient.send(arViewData)
  }
}

//MARK: - Video streaming
extension RealityCheckConnectViewModel {

  func startVideoStreaming() async {
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
