import AppFeature
import ComposableArchitecture
import Dependencies
import Models
import MultipeerClient
import StreamingClient
import SwiftUI

struct MainView: View {
  let store: StoreOf<AppCore>

  var sessionStateSubtitle: String {
    let viewStore = ViewStore(store, observe: \.multipeerConnection, removeDuplicates: ==)
    switch viewStore.sessionState {
      case .notConnected, .connecting(_):
        return ""

      case .connected(let peer):
        if let discoveryInfo = viewStore.peers[peer],
          let appName = discoveryInfo.appName,
          let appVersion = discoveryInfo.appVersion
        {
          return appName + " (\(appVersion))"
        } else {
          return ""
        }
    }
  }

  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      NavigationSplitView {
        SidebarView(store: store)
      } content: {
        ZStack {
          StreamingView(viewportSize: viewStore.binding(\.$viewPortSize))
            .frame(maxWidth: viewStore.viewPortSize.width, maxHeight: viewStore.viewPortSize.height)
            .aspectRatio(
              viewStore.viewPortSize.width / viewStore.viewPortSize.height,
              contentMode: .fit
            )
            .overlay {
              Rectangle().stroke()
            }
            .background(Color(nsColor: .controlBackgroundColor))
            .padding()
            .padding(.bottom, 32)

          SplitViewReader { proxy in
            SplitView(axis: .vertical) {
              Color.clear
                .safeAreaInset(edge: .bottom, spacing: 0) {
                  StatusBarView(proxy: proxy, collapsed: viewStore.binding(\.$isDumpAreaCollapsed))
                }

              TextEditor(text: .constant(viewStore.entitiesSection?.dumpOutput ?? "???"))
                .font(.body)
                .monospaced()
                .collapsable()
                .collapsed(viewStore.binding(\.$isDumpAreaCollapsed))
                .frame(minHeight: 200, maxHeight: .infinity)
            }
            .edgesIgnoringSafeArea(.top)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
          }
        }
        .background(Color(nsColor: .lightGray))

      } detail: {
        switch viewStore.selectedSection {
          case .none:
            Spacer().navigationSplitViewColumnWidth(0)

          case .arView:
            if let arView = viewStore.arViewSection?.arView {
              ARViewDetailView(arView)
                .navigationSplitViewColumnWidth(min: 270, ideal: 405, max: 810)
            }

          case .entities:
            if let entity = viewStore.entitiesSection?.selectedEntity {
              EntityDetailView(entity)
                .navigationSplitViewColumnWidth(min: 270, ideal: 405, max: 810)
            }
        }
      }
      .navigationSplitViewStyle(.balanced)
      .toolbar {
        ToolbarItem {
          SessionStateButtonView(viewStore.multipeerConnection.sessionState)
        }
      }
      .navigationSubtitle(sessionStateSubtitle)
    }
  }
}

struct SessionStateButtonView: View {
  @Environment(\.openWindow) private var openWindow
  private let sessionState: MultipeerClient.SessionState

  init(
    _ sessionState: MultipeerClient.SessionState
  ) {
    self.sessionState = sessionState
  }

  var contextualBackground: Color {
    switch sessionState {
      case .notConnected:
        return .red
      case .connecting:
        return .orange
      case .connected:
        return .green
    }
  }

  var contextualLabel: String {
    switch sessionState {
      case .notConnected:
        return "notConnected"
      case .connecting:
        return "connecting"
      case .connected:
        return "connected"
    }
  }

  var body: some View {
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

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainView(
      store: .init(
        initialState: AppCore.State(
          //FIXME: avoid constructor cleaning mock return
          arViewSection: ARViewSection.State.init(
            arView: .init(
              .init(frame: .zero),
              anchors: [],
              contentScaleFactor: 1
            )
          ),
          entitiesSection: .init([], selection: 14_973_088_022_893_562_172)
        ),
        reducer: AppCore()
      )
    )
    .navigationSplitViewStyle(.prominentDetail)
    .frame(width: 500, height: 900)
  }
}
