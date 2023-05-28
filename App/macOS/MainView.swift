import AppFeature
import ComposableArchitecture
import Dependencies
import Models
import StreamingClient
import SwiftUI

struct MainView: View {
  @Environment(\.openWindow) var openWindow
  @State private var terminalCollapsed = true
  let store: StoreOf<AppCore>

  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in

      var contextualBackground: Color {
        switch viewStore.multipeerConnection.sessionState {
          case .notConnected:
            return .red
          case .connecting:
            return .orange
          case .connected:
            return .green
        }
      }

      var contextualLabel: String {
        switch viewStore.multipeerConnection.sessionState {
          case .notConnected:
            return "notConnected"
          case .connecting:
            return "connecting"
          case .connected:
            return "connected"
        }
      }

      NavigationSplitView {
        Sidebar(store: store)
      } content: {
        ZStack {
          StreamingView()
            .frame(width: 400, height: 800)
            .overlay {
                Rectangle().stroke()
            }

          SplitViewReader { proxy in
            SplitView(axis: .vertical) {
              Color.clear
                .safeAreaInset(edge: .bottom, spacing: 0) {
                  StatusBarView(proxy: proxy, collapsed: $terminalCollapsed)
                }

              TextEditor(text: .constant(viewStore.entitiesHierarchy?.dumpOutput ?? "???"))
                .font(.body)
                .monospaced()
                .collapsable()
                .collapsed($terminalCollapsed)
                .frame(minHeight: 200, maxHeight: .infinity)
            }
            .edgesIgnoringSafeArea(.top)
            .frame(maxWidth: .infinity, maxHeight: .infinity)

          }
        }
      } detail: {
        Group {
          if let entity = viewStore.entitiesHierarchy?.selectedEntity {
            EntityDetailView(entity: entity)
          } else {
            Text("Pick an entity")
          }
        }
        .navigationSplitViewColumnWidth(min: 270, ideal: 405, max: 810)
        .navigationSplitViewStyle(.balanced)
      }
      .toolbar {
        ToolbarItem {
          Button(
            action: {
              openWindow(id: "ConnectionWindowID")
            },
            label: {
              Text(contextualLabel)
                .foregroundColor(.white)
                .font(.caption)
                .padding(8)
                .background(Capsule(style: .continuous).fill(contextualBackground))
            }
          )
          .buttonStyle(.plain)
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainView(
      store: .init(
        initialState: AppCore.State(
          //FIXME: avoid constructor cleaning mock return
          arViewOptions: ARViewOptions.State.init(arView: .init(.init(frame: .zero), anchors: [])),
          entitiesHierarchy: .init([], selection: 14_973_088_022_893_562_172)
        ),
        reducer: AppCore()
      )
    )
    .navigationSplitViewStyle(.prominentDetail)
    .frame(width: 500, height: 900)
  }
}
