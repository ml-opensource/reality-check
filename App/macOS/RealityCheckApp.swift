import AppFeature
import ComposableArchitecture
import SwiftUI

enum WindowID: String {
  case connection
  case main
}

@main
@available(macOS 14.0, *)
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
    Window("Welcome to RealityCheck", id: WindowID.connection.rawValue) {
      ConnectionSetupView(
        store: store.scope(
          state: \.multipeerConnection,
          action: AppCore.Action.multipeerConnection
        )
      )
    }
    .windowResizability(.contentSize)
    .defaultPosition(.center)
    .windowStyle(.hiddenTitleBar)

    Window("RealityCheck", id: WindowID.main.rawValue) {
      MainView(store: store)
    }
    .commands {
      CommandGroup(replacing: .help) {
        let helpURL = URL(
          string:
            "https://monstar-lab-oss.github.io/reality-check/documentation/realitycheckconnect/gettingstarted"
        )!

        // Default: "RealityCheck Help"
        Link("Getting Started", destination: helpURL)
      }
    }
  }
}
