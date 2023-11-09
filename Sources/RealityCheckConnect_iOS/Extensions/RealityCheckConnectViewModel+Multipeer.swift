import Foundation
import Models
import RealityCodable
import RealityDump
import RealityKit  //FIXME: avoid depending directly

extension RealityCheckConnectViewModel {
  func startMultipeerSession() async {

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
              connectionState = state

              if case .connected = state {
                /// Send Hierarchy on connect
                await sendMultipeerData()
              }

            case .didReceiveData(let data):
              /// ARView Debug Options
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
              }/// Entity selection
              else if let entitySelection = try? defaultDecoder.decode(
                EntitySelection.self,
                from: data
              ) {
                selectedEntityID = entitySelection.entityID
                await sendSelectedEntityMultipeerRawData()
                // TODO: display selection
                // if let entity = await arView?
                //   .findEntityIdentified(targetID: entitySelection.entityID)
                // {
                //   await MainActor.run {
                //     let parentBounds = entity.visualBounds(relativeTo: nil)
                //     selectionEntity.setParent(entity)
                //     // selectionEntity.setPosition(parentBounds.center, relativeTo: nil)
                //     // selectionEntity.position.y = parentBounds.extents.y
                //   }
                // }
              } else {
                fatalError("Unknown data was received.")
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
    multipeerClient.send(arViewData)
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
        // multipeerClient.send(rawData)
      }
    }
  }
}
