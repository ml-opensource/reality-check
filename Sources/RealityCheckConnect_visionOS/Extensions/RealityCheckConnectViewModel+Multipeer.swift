import Dependencies
import Foundation
import Models
import MultipeerClient
import RealityCodable
import RealityDump

extension RealityCheckConnectViewModel {
  func startMultipeerSession() async throws {

    /// Setup
    for await action in try await multipeerClient.start(
      serviceName: "reality-check",
      sessionType: .peer,
      discoveryInfo: AppInfo.discoveryInfo
    ) {
      switch action {
        case .session(let sessionAction):
          switch sessionAction {
            case .stateDidChange(let state):
              connectionState = state

              if case .connected = state {
                /// Send Hierarchy on connect
                await sendMultipeerData()
              }

            case .didReceiveData(let data):
              guard let sessionEvent = RealityPlatform.visionOS.SessionEvent(data: data) else {
                fatalError("Unknown data was received.")
              }

              switch sessionEvent {
                case .entitySelected(let entityID):
                  selectedEntityID = entityID
                  await sendSelectedEntityMultipeerRawData()
                
                case .disconnectionRequested:
                  await multipeerClient.disconnect()
              }
          }

        case .browser:
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
    guard case .connected = connectionState else { return }
    var rootEntities: [RealityPlatform.visionOS.EntityType] = []

    for content in scenes.values {
      guard let root = content.root else { return }
      rootEntities.append(await root.encoded)
    }

    let sceneData = try! defaultEncoder.encode(
      RealityPlatform.visionOS.Scene(children: rootEntities)
    )

    await multipeerClient.send(sceneData)
  }

  fileprivate func sendSelectedEntityMultipeerRawData() async {
    guard let selectedEntityID else { return }

    for scene in scenes.values {
      guard let root = scene.root else { return }

      //TODO: It appears that visionOS has a new "locate by ID" API. Have a look at it.
      if let selectedEntity = await root.findEntity(id: selectedEntityID) {
        let rawData = try! defaultEncoder.encode(String(customDumping: selectedEntity))
        await multipeerClient.send(rawData)
      }
    }
  }
}
