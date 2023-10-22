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
        return ""

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
              StatusBarView(
                proxy: proxy,
                collapsed: viewStore.binding(
                  get: { !$0.isConsolePresented },
                  send: { .binding(.set(\.$isConsolePresented, !$0)) }
                )
              )
            }

            TextEditor(text: .constant(viewStore.entitiesSection?.dumpOutput ?? "..."))
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
          .edgesIgnoringSafeArea(.top)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationSplitViewColumnWidth(min: 367, ideal: 569, max: .infinity)
      }
      .navigationSplitViewStyle(.balanced)
      .toolbar(id: "Main") {
        ToolbarItem(id: "SessionState") {
          SessionStateButtonView(viewStore.multipeerConnection.sessionState)
        }
        ToolbarItem(id: "ConnectionSetup") {
          Button("Connection Setup", systemImage: "dot.radiowaves.left.and.right") {
            viewStore.send(.binding(.set(\.$isConnectionSetupPresented, true)))
          }
          .popover(
            isPresented: viewStore.$isConnectionSetupPresented,
            content: {
              ConnectionSetupView(
                store: store.scope(
                  state: \.multipeerConnection,
                  action: AppCore.Action.multipeerConnection
                )
              )
            }
          )
        }
        ToolbarItem(id: "Console") {
          Toggle(
            isOn: viewStore.$isConsolePresented,
            label: { Label("Console", systemImage: "doc.plaintext") }
          )
          .keyboardShortcut("C", modifiers: [.command, .option])
        }
      }
      .inspector(isPresented: viewStore.$isInspectorDisplayed) {
        switch viewStore.selectedSection {
          case .arView:
            //FIXME:
            EmptyView()
          // if let arView = viewStore.arViewSection?.arView {
          //   ARViewInspectorView(arView)
          //     .navigationSplitViewColumnWidth(min: 270, ideal: 405, max: 810)
          // }

          case .entities:
            IfLetStore(
              store.scope(
                state: \.entitiesSection,
                action: AppCore.Action.entitiesNavigator
              )
            ) {
              InspectorView($0)
                .inspectorColumnWidth(min: 277, ideal: 569, max: 811)
                .interactiveDismissDisabled()
            }
        }
      }
      .navigationTitle(sessionTitle)
      .navigationSubtitle(sessionSubtitle)
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
      RoundedRectangle(cornerRadius: 16, style: .continuous)
        .fill(Color(nsColor: .controlBackgroundColor))
        .shadow(radius: 1)
    )
  }
}
