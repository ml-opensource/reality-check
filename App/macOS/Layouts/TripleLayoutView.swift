import AppFeature
import ComposableArchitecture
import StreamingClient
import SwiftUI

struct TripleLayoutView: View {
  @Environment(\.openWindow) var openWindow
  @State var store: StoreOf<AppCore>

  var body: some View {
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
                  .opacity(store.isStreaming ? 0 : 1)
              )

            if store.isStreaming {
              MetalViewRepresentable(viewportSize: $store.viewPortSize)
                .frame(
                  maxWidth: store.viewPortSize.width,
                  maxHeight: store.viewPortSize.height
                )
                .aspectRatio(
                  store.viewPortSize.width / store.viewPortSize.height,
                  contentMode: .fit
                )
            } else {
              VideoPreviewPaused().padding()
            }
          }
          .safeAreaInset(edge: .bottom, spacing: 0) {
            if !store.isConsoleDetached {
              ConsoleStatusBar(
                proxy: proxy,
                collapsed: Binding(
                  get: { !store.isConsolePresented },
                  set: { store.isConsolePresented = !$0 }
                ),
                detached: $store.isConsoleDetached
              )
            }
          }

          if !store.isConsoleDetached {
            TextEditor(
              text: .constant(
                store.entitiesNavigator?.dumpOutput ?? "No dump output received..."
              )
            )
            .font(.system(.body, design: .monospaced))
            .collapsable()
            .collapsed(
              Binding(
                get: { !store.isConsolePresented },
                set: { store.isConsolePresented = !$0 }
              )
            )
            .frame(minHeight: 200, maxHeight: .infinity)
          }
        }
        .customOnChange(of: store.isConsoleDetached) {
          openWindow(id: WindowID.console.rawValue)
        }
        .edgesIgnoringSafeArea(.top)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
      .navigationSplitViewColumnWidth(min: 367, ideal: 569, max: .infinity)
      .navigationSplitViewStyle(.balanced)
    }
    .modifier(Inspector(store: store))
  }
}
