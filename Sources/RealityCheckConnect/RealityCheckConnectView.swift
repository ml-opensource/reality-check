import Dependencies
import Models
import MultipeerClient
import RealityDumpClient
import RealityKit
import StreamingClient
import SwiftUI

//TODO: allow customization on construction (or via modifiers)
public struct RealityCheckConnectView: View {
  @State private var connectionState: MultipeerClient.SessionState = .notConnected
  @State private var hostName: String = "..."

  @Dependency(\.multipeerClient) var multipeerClient
  @Dependency(\.realityDump) var realityDump
  @Dependency(\.streamingClient) var streamingClient

  private var arView: ARView?

  public init(
    _ arView: ARView? = nil
  ) {
    self.arView = arView
  }

  public var body: some View {
    VStack {
      switch connectionState {
        case .notConnected:
          Text("notConnected")
            .font(.caption)
            .padding(8)
            .background(Capsule(style: .continuous).fill(.red))

          Spacer()

        case .connecting:
          Text("connecting")
            .font(.caption)
            .padding(8)
            .background(Capsule(style: .continuous).fill(.orange))

          Spacer()

        case .connected:
          ConnectedView(hostName: hostName)
      }
    }
    .animation(.default, value: connectionState)
    .task {
      //MARK: 1. Setup
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
                if state == .connected {
                  //MARK: 2. Send Hierarchy
                  await sendHierarchy()
                }

              case .didReceiveData(_):
                //TODO:
                break
            }

          case .browser(_):
            return

          case .advertiser(let advertiserAction):
            switch advertiserAction {
              case .didReceiveInvitationFromPeer(let peer):
                multipeerClient.acceptInvitation()
                multipeerClient.stopAdvertisingPeer()
                hostName = peer.displayName
            }
        }
      }
    }
  }

  private func sendHierarchy() async {
    let anchors = await arView?.scene.anchors.compactMap({ $0 }) ?? []
    var identifiableEntities: [IdentifiableEntity] = []
    for anchor in anchors {
      identifiableEntities.append(
        await realityDump.identify(anchor)
      )
    }

    let encoder = JSONEncoder()
    encoder.nonConformingFloatEncodingStrategy = .convertToString(
      positiveInfinity: "INF",
      negativeInfinity: "-INF",
      nan: "NAN"
    )
    encoder.outputFormatting = .prettyPrinted
    let hierarchyData = try! encoder.encode(identifiableEntities)
    print(">>>:", String(data: hierarchyData, encoding: .utf8)!)
    multipeerClient.send(hierarchyData)
  }
}

#if DEBUG
  struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      RealityCheckConnectView()
    }
  }
#endif
