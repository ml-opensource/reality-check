import Dependencies
import Models
import MultipeerClient
import RealityDumpClient
import RealityKit
import StreamingClient
import SwiftUI

/**
Represents a SwiftUI view for controlling the RealityCheck connection and exchange of  the running AR experience data.

Use the `RealityCheckConnectView` struct to display the state of the connection and provide a user interface for establishing a connection with **RealityCheck** macOS app. Once integrated, the GUI will allow to connect and exchange AR scene hierarchy data. It utilizes SwiftUI for rendering the user interface. and can be accessed as a `LibraryItem` from the `Library` panel.

**Usage**

1. Initialize `RealityCheckConnectView` and provide an optional `ARView` instance to enable hierarchy sending functionality.
2. Add `RealityCheckConnectView` to your SwiftUI view hierarchy.

**Example**

Here's an example of how to use `RealityCheckConnectView`:
```swift
var body: some View {
    ZStack {
        // Other views
        RealityCheckConnectView(arView)
    }
}
```
 */
public struct RealityCheckConnectView: View {
  //TODO: allow customization on construction (or via modifiers)
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

              case .didReceiveData(let data):
                //MARK: ARView Debug Options
                if let debugOptions = try? JSONDecoder()
                  .decode(
                    _DebugOptions.self,
                    from: data
                  )
                {
                  arView?.debugOptions = ARView.DebugOptions(rawValue: debugOptions.rawValue)
                }
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
    guard let arView else {
      //FIXME: make a runtime error instead
      fatalError("ARView is required in order to be able to send its hierarchy")
    }

    let encoder = JSONEncoder()
    encoder.nonConformingFloatEncodingStrategy = .convertToString(
      positiveInfinity: "INF",
      negativeInfinity: "-INF",
      nan: "NAN"
    )
    encoder.outputFormatting = .prettyPrinted

    let anchors = await arView.scene.anchors.compactMap { $0 }
    var identifiableAnchors: [IdentifiableEntity] = []
    for anchor in anchors {
      identifiableAnchors.append(
        await realityDump.identify(anchor)
      )
    }

    let arViewData = try! await encoder.encode(
      CodableARView(
        arView,
        anchors: identifiableAnchors,
        contentScaleFactor: arView.contentScaleFactor
      )
    )
    multipeerClient.send(arViewData)
  }
}

#if DEBUG
  struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      RealityCheckConnectView()
    }
  }
#endif
