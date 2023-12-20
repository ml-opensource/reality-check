import AppFeature
import ComposableArchitecture
import SwiftUI

struct DoubleLayoutView: View {
  @Environment(\.openWindow) var openWindow
  @State var store: StoreOf<AppCore>

  var body: some View {
    SplitViewReader { proxy in
      SplitView(axis: .vertical) {
        NavigatorView(store: store)
          .frame(maxHeight: .infinity)
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
  }
}
