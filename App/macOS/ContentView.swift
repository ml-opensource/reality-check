import AppFeature
import ComposableArchitecture
import Dependencies
import Models
import StreamingClient
import SwiftUI

struct ContentView: View {
  @State private var points: [SIMD3<Float>] = []
  let store: StoreOf<AppCore>

  @State private var isPresented = false

  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      NavigationSplitView {
        Sidebar(viewStore: viewStore)
      } content: {
        if viewStore.multipeerConnection.sessionState == .connected {
          ZStack {
            StreamingView()
              .frame(width: 400, height: 800)

            VSplitView {
              Color.clear
              TextEditor(text: .constant(viewStore.dumpOutput))
                .monospaced()
                // .foregroundColor(.cyan)
                .multilineTextAlignment(.leading)
            }
          }
        } else {
          List(viewStore.multipeerConnection.peers) { peer in
            Button(
              action: {
                viewStore.send(.multipeerConnection(.invite(peer)))
              },
              label: {
                Label(
                  title: { Text(peer.displayName) },
                  icon: { Image(systemName: "phone") }
                )
              }
            )
            .padding(2)
            .buttonStyle(.bordered)
            .controlSize(.large)
          }
          .animation(.easeInOut, value: viewStore.multipeerConnection.peers)
        }
      } detail: {
        Group {
          if let entity = viewStore.selectedEntity {
            EntityDetailView(entity: entity)
          } else {
            Text("Pick an entity")
          }
        }
        .navigationSplitViewColumnWidth(min: 270, ideal: 405, max: 810)
        .navigationSplitViewStyle(.prominentDetail)
      }
      .toolbar {
        ToolbarItem {
          switch viewStore.multipeerConnection.sessionState {
            case .notConnected:
              Text("notConnected")
                .foregroundColor(.white)
                .font(.caption)
                .padding(8)
                .background(Capsule(style: .continuous).fill(.red))

            case .connecting:
              Text("connecting")
                .foregroundColor(.white)
                .font(.caption)
                .padding(8)
                .background(Capsule(style: .continuous).fill(.yellow))

            case .connected:
              Text("connected")
                .foregroundColor(.white)
                .font(.caption)
                .padding(8)
                .background(Capsule(style: .continuous).fill(.green))
          }
        }
      }
      .task {
        viewStore.send(.multipeerConnection(.start))
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(
      store: .init(
        initialState: AppCore.State(selection: 14_973_088_022_893_562_172),
        reducer: AppCore()
      )
    )
    .navigationSplitViewStyle(.prominentDetail)
  }
}
