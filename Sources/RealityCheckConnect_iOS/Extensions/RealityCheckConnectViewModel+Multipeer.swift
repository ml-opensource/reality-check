import Foundation
import Models
import RealityCodable
import RealityDump
import RealityKit  //FIXME: avoid depending directly

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
              self.connectionState = state
              if case .connected = state {
                /// Send Hierarchy on connect
                await sendMultipeerData()
              }

            case .didReceiveData(let data):
              guard let sessionEvent = RealityPlatform.iOS.SessionEvent(data: data) else {
                fatalError("Unknown data was received.")
              }

              switch sessionEvent {
                case .entitySelected(let entityID):
                  selectedEntityID = entityID
                  await sendSelectedEntityMultipeerRawData()

                case .debugOptionsUpdated(let options):
                  await MainActor.run {
                    arView?.debugOptions = ARView.DebugOptions(
                      rawValue: options.rawValue
                    )
                  }
                case .disconnectionRequested:
                  await multipeerClient.disconnect()
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
    guard case .connected = connectionState else { return }
    guard let arView else {
      //FIXME: Turn it into a runtime error
      fatalError("You need an ARView to send its hierarchy.")
    }
    var rootEntities: [RealityPlatform.iOS.EntityType] = []

    let anchors = await arView.scene.anchors.map({ $0 })
    for anchor in anchors {
      rootEntities.append(await anchor.encoded)
    }

    let arViewData = try! await defaultEncoder.encode(
      RealityPlatform.iOS.ARView(
        arView,
        anchors: rootEntities,
        contentScaleFactor: arView.contentScaleFactor
      )
    )
    await multipeerClient.send(arViewData)
  }

  fileprivate func sendSelectedEntityMultipeerRawData() async {
    guard
      let arView,
      let selectedEntityID
    else { return }

    //    var rawDump: [String] = []
    //
    //      //FIXME: rawDump.append(String(customDumping: anchor))
    //
    //    let rawData = try! defaultEncoder.encode(rawDump.reduce("", +))
    //    multipeerClient.send(rawData)

    let anchors = await arView.scene.anchors.map({ $0 })

    for anchor in anchors {
      if let selectedEntity = await anchor.findEntity(id: selectedEntityID) {
        //FIXME: find missing Mirror
         // let rawData = try! defaultEncoder.encode(String(customDumping: selectedEntity))
        // await multipeerClient.send(rawData)
      }
    }
  }
}
