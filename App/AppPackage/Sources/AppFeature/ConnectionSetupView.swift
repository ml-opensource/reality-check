import ComposableArchitecture
import MultipeerClient
import SwiftUI

struct ConnectionSetupView: View {

  @Environment(\.openURL) private var openURL
  let store: StoreOf<MultipeerConnection>
  let helpURL = URL(
    string:
      "https://monstar-lab-oss.github.io/reality-check/documentation/realitycheckconnect/gettingstarted"
  )!

  var body: some View {
    //TODO: scope the viewStore to only observe "Peers"
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      NavigationStack {
        if viewStore.peers.isEmpty {
          ZStack {
            ContentUnavailableView(
              "No Inspectable Apps",
              systemImage: "app.dashed",
              description: Text("Make your app inspectable by integrating RealityCheckConnect")
            )

            VStack {
              Spacer()
              HStack {
                Spacer()
                HelpLink(destination: helpURL)
              }
            }
          }
          .padding()
        } else {
          //TODO: add selection
          List(Array(viewStore.peers.keys)) { peer in
            PeerConnectionView(peer: peer, viewStore: viewStore)
              .listRowSeparator(.hidden)
          }
          .navigationTitle("Inspectable apps")
        }
      }
      .animation(.easeInOut, value: viewStore.peers)
      .task {
        viewStore.send(.start)
      }
    }
    .frame(width: 521 / 1.25, height: 521 / 2)
  }
}

struct PeerConnectionView: View {

  @Environment(\.openWindow) var openWindow
  let peer: Peer

  @ObservedObject
  var viewStore: ViewStoreOf<MultipeerConnection>

  //FIXME: refactor this to default platform extension info
  var appIconSystemName: String {
    guard let device = viewStore.peers[peer]?.device else { return "app" }
    if device.lowercased().contains("vision") {
      return "circle.fill"
    } else {
      return "app.fill"
    }
  }

  var body: some View {
    let discoveryInfo: DiscoveryInfo? = viewStore.peers[peer]
    let isConnected: Bool = viewStore.connectedPeer?.peer == peer

    GroupBox {
      HStack {
        Image(systemName: appIconSystemName)
          .resizable()
          .aspectRatio(1, contentMode: .fit)
          .frame(minWidth: 30, maxWidth: 60)
          .foregroundColor(colorFromHash(discoveryInfo?.colorHash ?? peer.displayName))
          .overlay {
            VStack(spacing: 2) {
              if let device = discoveryInfo?.device {
                Image(
                  systemName: device.lowercased().contains("vision")
                    ? "visionpro"
                    : "iphone"
                )
              }

              if let appVersion = discoveryInfo?.appVersion {
                Text(appVersion)
                  .font(.caption)
              }
            }
          }

        VStack(alignment: .leading) {
          if let appName = discoveryInfo?.appName {
            Text(appName)
              .font(.title2)
          }

          HStack(alignment: .bottom) {
            if let device = discoveryInfo?.device {
              Text(device)
                .foregroundStyle(.secondary)
            }

            if let system = discoveryInfo?.system {
              Text(system)
                .font(.caption)
                .foregroundStyle(.secondary)
            }
          }
        }

        Spacer()

        Button(
          isConnected ? "Disconnect" : "Connect",
          systemImage: isConnected ? "stop.fill" : "play.fill"
        ) {
          if isConnected {
            viewStore.send(.disconnectCurrentPeer)
          } else {
            viewStore.send(.invite(peer))
          }
        }
        .controlSize(.extraLarge)
      }
      .padding(2)
      //FIXME: .help("Insert coin to continue")
    }
    .accessibilityElement()
    .accessibilityLabel("TEst")
    .accessibilityRepresentation {
      ZStack {
        if let appName = discoveryInfo?.appName {
          Text(appName)
        }
        
        if let device = discoveryInfo?.device {
          Text("running on ") +
          Text(device)
          if let system = discoveryInfo?.system {
            Text(system)
          }
        }
      }
      .accessibilityElement(children: .combine)
// .accessibilityAction {
//   if isConnected {
//     viewStore.send(.disconnectCurrentPeer)
//   } else {
//     viewStore.send(.invite(peer))
//   }
// }
    }
  }
}

struct ConnectionSetupView_Previews: PreviewProvider {
  static var previews: some View {
    ConnectionSetupView(
      store: Store(
        initialState: AppCore.State(
          multipeerConnection: .init()
        ),
        reducer: AppCore.init
      )
      .scope(
        state: \.multipeerConnection,
        action: AppCore.Action.multipeerConnection
      )
    )

    ConnectionSetupView(
      store: Store(
        initialState: AppCore.State(
          multipeerConnection: .init(
            peers: [
              Peer(displayName: "Manolo"): DiscoveryInfo(
                appName: "MyAugmentedApp",
                appVersion: "5.3 (127)",
                device: "iPhone 12 Pro",
                system: "iOS 15.1"
              )
            ]
          )
        ),
        reducer: AppCore.init
      )
      .scope(
        state: \.multipeerConnection,
        action: AppCore.Action.multipeerConnection
      )
    )

    ConnectionSetupView(
      store: Store(
        initialState: AppCore.State(
          multipeerConnection: .init(
            peers: [
              Peer(displayName: "Manolo"): DiscoveryInfo(
                appName: "MyAugmentedApp",
                appVersion: "5.3 (127)",
                device: "iPhone 12 Pro",
                system: "iOS 15.1"
              ),
              Peer(displayName: "Manolo"): DiscoveryInfo(
                appName: "TheAugmentedApp",
                appVersion: "0.3 (17)",
                device: "iPhone 12 Pro",
                system: "iOS 15.1"
              ),
              Peer(displayName: "Manolo"): DiscoveryInfo(
                appName: "MyRealAR",
                appVersion: "1.5.1 (12)",
                device: "iPhone 12 Pro",
                system: "iOS 15.1"
              ),
              Peer(displayName: "Manolo"): DiscoveryInfo(
                appName: "SomethingInTheAR",
                appVersion: "5.3 (99)",
                device: "iPhone 11",
                system: "iOS 12.5"
              ),
              Peer(displayName: "Manolo"): DiscoveryInfo(
                appName: "Appgmented",
                appVersion: "15.0 (2)",
                device: "iPhone X",
                system: "iOS 16.5"
              ),
            ]
          )
        ),
        reducer: AppCore.init
      )
      .scope(
        state: \.multipeerConnection,
        action: AppCore.Action.multipeerConnection
      )
    )
  }
}
