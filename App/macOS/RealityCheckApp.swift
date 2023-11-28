import AppFeature
import ComposableArchitecture
import SwiftUI

enum WindowID: String {
  case connection
  case console
  case main
}

@main
struct RealityCheckApp: App {
  let store: StoreOf<AppCore> = .init(
    initialState: AppCore.State(),
    reducer: {
      AppCore()
        #if MULTIPEER_MOCK
          .dependency(\.multipeerClient, .testValue)
        #endif
    }
  )

  var body: some Scene {
    Window("RealityCheck", id: WindowID.main.rawValue) {
      MainView(store: store)
    }
    .windowResizability(.automatic)
    .commands {
      InspectorCommands()
      SidebarCommands()
      ToolbarCommands()
      CommandGroup(replacing: .help) {
        let helpURL = URL(
          string:
            "https://monstar-lab-oss.github.io/reality-check/documentation/realitycheckconnect/gettingstarted"
        )!
        Link("Getting Started", destination: helpURL)
      }
    }

    Window("Console", id: WindowID.console.rawValue) {
      @Environment(\.dismissWindow) var dismissWindow

      let output = store.entitiesNavigator?.dumpOutput ?? "No dump output received..."
      TextEditor(text: .constant(output))
        .font(.system(.body, design: .monospaced))
        .toolbar {
          ToolbarItem {
            Button(
              "Attach Console",
              systemImage: "square.bottomthird.inset.filled",
              action: {
                store.send(.binding(.set(\.isConsoleDetached, false)))
                dismissWindow(id: WindowID.console.rawValue)
              }
            )
            .help("Attach the console to the main window")
          }

          ToolbarItem {
            ShareLink(item: output)
          }
        }
    }
    .windowToolbarStyle(.unifiedCompact)
  }
}
