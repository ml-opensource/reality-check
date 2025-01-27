import AppFeature
import ComposableArchitecture
import MultipeerClient
import SwiftUI

struct ConnectionSetupView: View {
  @Environment(\.openURL) private var openURL

  let store: StoreOf<MultipeerConnection>
  var columns: [GridItem] {
    [
      .init(.flexible()),
      .init(.flexible()),
      .init(.flexible()),
    ]
  }

  var body: some View {
    //TODO: scope the viewStore to only observe "Peers"
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      VStack(spacing: 0) {
        ScrollView(.vertical) {
          LazyVGrid(columns: columns, alignment: .leading) {
            ForEach(Array(viewStore.peers.keys)) { peer in
              PeerConnectView(peer: peer, viewStore: viewStore)
            }
          }
          .padding()
        }
        .overlay(
          Group {
            if viewStore.peers.isEmpty {
              Text("Inspectable apps will appear here.")
                .foregroundColor(.secondary)
            }
          }
        )
        .animation(.easeInOut, value: viewStore.peers)
        .task {
          viewStore.send(.start)
        }

        Divider()

        HStack {
          Button(
            action: {
              openURL(
                URL(
                  string:
                    "https://monstar-lab-oss.github.io/reality-check/documentation/realitycheckconnect/gettingstarted"
                )!
              )
            },
            label: {
              Label("Getting Started", systemImage: "questionmark.circle")
            }
          )
          .controlSize(.large)

          Spacer()
        }
        .padding()
        .background(.bar)
      }
      .frame(width: 521, height: 521)
    }
  }
}

struct PeerConnectView: View {
  @Environment(\.openWindow) private var openWindow
  let peer: Peer
  @ObservedObject var viewStore: ViewStoreOf<MultipeerConnection>

  var body: some View {
    let discoveryInfo: DiscoveryInfo? = viewStore.peers[peer]
    Button(
      action: {
        viewStore.send(.invite(peer))
        openWindow(id: "RealityCheckWindowID")
      },
      label: {
        VStack {
          Image(systemName: "app.fill")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .fontWeight(.thin)
            .foregroundColor(colorFromHash(discoveryInfo?.colorHash ?? peer.displayName))

          if let appName = discoveryInfo?.appName {
            Text(appName)
              .font(.headline)
          }

          if let appVersion = discoveryInfo?.appVersion {
            Text(appVersion)
              .font(.caption2)
              .foregroundColor(.secondary)
          }

          GroupBox {
            if let device = discoveryInfo?.device {
              Label(device, systemImage: "iphone")
            }

            if let system = discoveryInfo?.system {
              Text(system)
            }
          }
          .font(.caption2)
        }
        .padding()
        .background(
          RoundedRectangle(cornerRadius: 4, style: .continuous)
            .fill(Color(nsColor: .controlBackgroundColor))
        )
        .drawingGroup()
        .overlay(
          RoundedRectangle(cornerRadius: 4, style: .continuous)
            .stroke(lineWidth: 0.2)
            .foregroundColor(.secondary)
        )
      }
    )
    .buttonStyle(.plain)
    .shadow(radius: 8, y: 8)
    .help("Insert coin to continue")
  }
}

struct ConnectionSetupView_Previews: PreviewProvider {
  static var previews: some View {
    let previewStore1 = Store(
      initialState: AppCore.State(
        multipeerConnection: .init()
      ),
      reducer: { AppCore() }
    )
    .scope(
      state: \.multipeerConnection,
      action: AppCore.Action.multipeerConnection
    )

    ConnectionSetupView(
      store: previewStore1
    )
    
    //MARK: -

    let previewStore2 = Store(
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
      reducer: { AppCore() }
    )
    .scope(
      state: \.multipeerConnection,
      action: AppCore.Action.multipeerConnection
    )

    ConnectionSetupView(store: previewStore2)

    //MARK: -

    let previewStore3 = Store(
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
      reducer: { AppCore() }
    )
    .scope(
      state: \.multipeerConnection,
      action: AppCore.Action.multipeerConnection
    )

    ConnectionSetupView(store: previewStore3)
  }
}
