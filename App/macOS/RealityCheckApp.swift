import AppFeature
import ComposableArchitecture
import SwiftUI

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
    Window("Welcome to RealityCheck", id: "ConnectionWindowID") {
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

    Window("RealityCheck", id: "RealityCheckWindowID") {
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
