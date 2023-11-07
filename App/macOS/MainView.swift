import AppFeature
import ComposableArchitecture
import Dependencies
import Models
import MultipeerClient
import StreamingClient
import SwiftUI

//FIXME: Relax the requirements, this is only required because the .inspector
@available(macOS 14.0, *)
struct MainView: View {
  let store: StoreOf<AppCore>

  var sessionTitle: String {
    let viewStore = ViewStore(store, observe: \.multipeerConnection, removeDuplicates: ==)
    switch viewStore.sessionState {
      case .notConnected, .connecting:
        return "RealityCheck"

      case .connected:
        if let connectedPeer = viewStore.connectedPeer,
          let appName = connectedPeer.discoveryInfo?.appName
        {
          return appName
        } else {
          return "RealityCheck"
        }
    }
  }

  var sessionSubtitle: String {
    let viewStore = ViewStore(store, observe: \.multipeerConnection, removeDuplicates: ==)
    switch viewStore.sessionState {
      case .notConnected, .connecting:
        return ""

      case .connected:
        if let connectedPeer = viewStore.connectedPeer,
          let appVersion = connectedPeer.discoveryInfo?.appVersion
        {
          return "􁎖 " + " \(appVersion)"
        } else {
          return ""
        }
    }
  }

  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      NavigationStack {
        switch viewStore.layout {
          case .double:
            NavigatorView(store: store).listStyle(.sidebar)
              .inspector(isPresented: viewStore.$isInspectorDisplayed) {
                IfLetStore(
                  store.scope(
                    state: \.entitiesSection,
                    action: AppCore.Action.entitiesNavigator
                  )
                ) {
                  Inspector_visionOS($0)
                    .inspectorColumnWidth(min: 277, ideal: 569, max: 811)
                    .interactiveDismissDisabled()
                }
              }

          case .triple:
            TripleLayoutView(store: store)
              .inspector(isPresented: viewStore.$isInspectorDisplayed) {
                IfLetStore(
                  store.scope(
                    state: \.entitiesSection,
                    action: AppCore.Action.entitiesNavigator
                  )
                ) {
                  Inspector_visionOS($0)
                    .inspectorColumnWidth(min: 277, ideal: 569, max: 811)
                    .interactiveDismissDisabled()
                }
              }
        }
      }
      .navigationTitle(sessionTitle)
      .navigationSubtitle(sessionSubtitle)
      .toolbar(id: "Main") {
        MainToolbar(store: store)
      }
    }
  }
}

@available(macOS 14.0, *)
struct TripleLayoutView: View {
  @Environment(\.openWindow) var openWindow
  let store: StoreOf<AppCore>

  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      NavigationSplitView {
        NavigatorView(store: store)
      } detail: {
        SplitViewReader { proxy in
          SplitView(axis: .vertical) {
            ZStack {
              Color.clear
                .background(
                  Image(.stripes)
                    .resizable(resizingMode: .tile)
                    .opacity(viewStore.isStreaming ? 0 : 1)
                )

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
              } else {
                VideoPreviewPaused().padding()
              }
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
              if !viewStore.isConsoleDetached {
                ConsoleStatusBar(
                  proxy: proxy,
                  collapsed: viewStore.binding(
                    get: { !$0.isConsolePresented },
                    send: { .binding(.set(\.$isConsolePresented, !$0)) }
                  ),
                  detached: viewStore.$isConsoleDetached
                )
              }
            }

            if !viewStore.isConsoleDetached {
              TextEditor(text: .constant(viewStore.entitiesSection?.dumpOutput ?? "No dump output received..."))
                .font(.system(.body, design: .monospaced))
                .collapsable()
                .collapsed(
                  viewStore.binding(
                    get: { !$0.isConsolePresented },
                    send: { .binding(.set(\.$isConsolePresented, !$0)) }
                  )
                )
                .frame(minHeight: 200, maxHeight: .infinity)
            }
          }
          .onChange(of: viewStore.isConsoleDetached) { oldValue, newValue in
            if newValue == true {
              openWindow(id: WindowID.console.rawValue)
            }
          }
          .edgesIgnoringSafeArea(.top)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationSplitViewColumnWidth(min: 367, ideal: 569, max: .infinity)
      }
      .navigationSplitViewStyle(.balanced)
    }
  }
}

struct VideoPreviewPaused: View {
  var body: some View {
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
      RoundedRectangle(cornerRadius: 8)
        .fill(Color(nsColor: .controlBackgroundColor))
        .shadow(radius: 1)
    )
  }
}

//FIXME: restore
//struct ContentView_Previews: PreviewProvider {
//  static var previews: some View {
//    MainView(
//      store: .init(
//        initialState: AppCore.State(
//          //FIXME: avoid constructor cleaning mock return
//          arViewSection: ARViewSection.State.init(
//            arView: .init(
//              .init(frame: .zero),
//              anchors: [],
//              contentScaleFactor: 1
//            )
//          ),
//          entitiesSection: .init([], selection: 14_973_088_022_893_562_172)
//        ),
//        reducer: {
//          AppCore()
//            .dependency(\.multipeerClient, .testValue)
//        }
//      )
//    )
//    .navigationSplitViewStyle(.prominentDetail)
//    .frame(width: 500, height: 900)
//  }
//}
