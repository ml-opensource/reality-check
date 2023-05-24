import AppFeature
import ComposableArchitecture
import MultipeerClient
import SwiftUI

struct ConnectionSetupView: View {
  @Environment(\.openWindow) var openWindow

  let store: StoreOf<MultipeerConnection>
  var columns: [GridItem] { [.init(.flexible())] }

  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      VStack(spacing: 0) {
        Text("RealityCheck")
          .font(.largeTitle)
          .padding()

        ScrollView(.vertical) {
          LazyVGrid(columns: columns, alignment: .center) {
            ForEach(Array(viewStore.peers.keys)) { peer in
              let discoveryInfo: DiscoveryInfo? = viewStore.peers[peer]
              Button(
                action: {
                  viewStore.send(.invite(peer))
                  openWindow(id: "RealityCheckWindowID")
                },
                label: {
                  VStack {
                    Image(systemName: "link.badge.plus")
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .padding()
                      .frame(width: 88, height: 88)
                      .foregroundColor(.purple)
                      .background {
                        Image(systemName: "app.dashed")
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                          .foregroundColor(.secondary)
                          .fontWeight(.thin)
                      }

                    if let appName = discoveryInfo?.appName {
                      Text(appName)
                        .font(.title2)

                    }

                    if let appVersion = discoveryInfo?.appVersion {
                      Text(appVersion)
                    }

                    GroupBox {
                      if let device = discoveryInfo?.device {
                        Label(device, systemImage: "iphone")
                      }

                      if let system = discoveryInfo?.system {
                        Text(system)
                      }
                    }
                  }
                  .padding(8)
                  .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(Color(nsColor: .controlBackgroundColor))
                  )
                  .drawingGroup()
                    // .overlay(
                    //   RoundedRectangle(cornerRadius: 8, style: .continuous)
                    //     .stroke(lineWidth: 4)
                    //     .foregroundColor(.white)
                    // )
                }
              )
              .buttonStyle(.plain)
              .shadow(radius: 16, y: 16)
              .help("Insert coin to continue")
            }
          }
          .padding(.top)
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
            action: {},
            label: {
              Label("Integrate Guide", systemImage: "questionmark.circle")
            }
          )
          .controlSize(.large)

          Spacer()
        }
        .padding()
        .background(.bar)
      }
      .frame(width: 300, height: 500)
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
        reducer: AppCore()
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
        reducer: AppCore()
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
                appName: "MyAugmentedApp",
                appVersion: "5.3 (127)",
                device: "iPhone 12 Pro",
                system: "iOS 15.1"
              ),
              Peer(displayName: "Manolo"): DiscoveryInfo(
                appName: "MyAugmentedApp",
                appVersion: "5.3 (127)",
                device: "iPhone 12 Pro",
                system: "iOS 15.1"
              ),
              Peer(displayName: "Manolo"): DiscoveryInfo(
                appName: "MyAugmentedApp",
                appVersion: "5.3 (127)",
                device: "iPhone 12 Pro",
                system: "iOS 15.1"
              ),
              Peer(displayName: "Manolo"): DiscoveryInfo(
                appName: "MyAugmentedApp",
                appVersion: "5.3 (127)",
                device: "iPhone 12 Pro",
                system: "iOS 15.1"
              ),
            ]
          )
        ),
        reducer: AppCore()
      )
      .scope(
        state: \.multipeerConnection,
        action: AppCore.Action.multipeerConnection
      )
    )
  }
}
