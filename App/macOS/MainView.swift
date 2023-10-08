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
      case .notConnected, .connecting:
        return ""

      case .connected:
        if let connectedPeer = viewStore.connectedPeer,
          let appName = connectedPeer.discoveryInfo?.appName,
          let appVersion = connectedPeer.discoveryInfo?.appVersion
        {
          return appName + " \(appVersion)"
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
          if viewStore.isStreaming {
            MetalViewRepresentable(viewportSize: viewStore.$viewPortSize)
              .frame(
                maxWidth: viewStore.viewPortSize.width,
                maxHeight: viewStore.viewPortSize.height
              )
              .aspectRatio(
                viewStore.viewPortSize.width / viewStore.viewPortSize.height,
                contentMode: .fit
              )
              .mask(RoundedRectangle(cornerRadius: 64, style: .continuous))
              .overlay {
                ///inner corner radius + padding = outer corner radius
                RoundedRectangle(cornerRadius: 64, style: .continuous)
                  .stroke()
                  .foregroundStyle(.secondary)
              }
              .padding()
              .padding(.bottom, 32)
          } else {
            PreviewPausedView()
          }

          SplitViewReader { proxy in
            SplitView(axis: .vertical) {
              Color.clear
                .safeAreaInset(edge: .bottom, spacing: 0) {
                  StatusBarView(proxy: proxy, collapsed: viewStore.$isConsoleCollapsed)
                }

              TextEditor(text: .constant(viewStore.entitiesSection?.dumpOutput ?? "..."))
                .font(.system(.body, design: .monospaced))
                .collapsable()
                .collapsed(viewStore.$isConsoleCollapsed)
                .frame(minHeight: 200, maxHeight: .infinity)
            }
            .edgesIgnoringSafeArea(.top)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
          }
        }
        .background(
          Image("stripes")
            .resizable(resizingMode: .tile)
            .scaleEffect(4)
            .opacity(viewStore.isStreaming ? 0 : 1)
        )
      } detail: {
        switch viewStore.selectedSection {
          case .none:
            Spacer().navigationSplitViewColumnWidth(0)

          case .arView:
            if let arView = viewStore.arViewSection?.arView {
              ARViewInspectorView(arView)
                .navigationSplitViewColumnWidth(min: 270, ideal: 405, max: 810)
            }

          case .entities:
            IfLetStore(
              store.scope(
                state: \.entitiesSection,
                action: AppCore.Action.entitiesSection
              ),
              then: EntityInspectorView.init
            )
            .navigationSplitViewColumnWidth(min: 270, ideal: 405, max: 810)
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
        return "not connected"
      case .connecting:
        return "connecting"
      case .connected:
        return "connected"
    }
  }

  var body: some View {
    Button(
      action: {
        openWindow(id: WindowID.connection.rawValue)
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
        reducer: {
          AppCore()
            .dependency(\.multipeerClient, .testValue)
        }
      )
    )
    .navigationSplitViewStyle(.prominentDetail)
    .frame(width: 500, height: 900)
  }
}

struct PreviewPausedView: View {
  var body: some View {
    VStack {
      HStack {
        Text("Screen capture paused")
          .font(.headline)

        Spacer().frame(maxWidth: 100)
        Button.init(
          "Help",
          systemImage: "questionmark.circle",
          action: {}
        )
        .controlSize(.large)
        .buttonStyle(.plain)
        .labelStyle(.iconOnly)
      }
      .padding()
      .background(
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(Color(nsColor: .controlBackgroundColor))
          .shadow(radius: 4)
      )
      Spacer()
    }
    .padding(.top, 32)
  }
}
