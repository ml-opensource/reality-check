import Dependencies
import Foundation
import Models
import MultipeerClient
import RealityCodable
import RealityDump

//MARK: - Multipeer
//FIXME: "Extensions must not contain stored properties" error for @Dependency
extension RealityCheckConnectViewModel {
  func startMultipeerSession() async {
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
              //TODO: Evaluate the impact of not running explicitly on the `MainActor`
              await MainActor.run {
                connectionState = state
              }

              if case .connected = state {
                /// Send Hierarchy on connect
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
          }
      }
    }
  }

  func sendMultipeerData() async {
    @Dependency(\.multipeerClient) var multipeerClient

    print(scenes.map(\.key))
    guard case .connected = connectionState else { return }
    var rootEntities: [RealityPlatform.visionOS.EntityType] = []

    for content in scenes.values {
      guard let root = content.root else { return }
      rootEntities.append(await root.encoded)
    }

    let realityViewData = try! defaultEncoder.encode(
      RealityPlatform.visionOS.Scene(children: rootEntities)
    )
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
