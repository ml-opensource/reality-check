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
    Window("RealityCheck", id: WindowID.main.rawValue) {
      MainView(store: store)
    }
    .commands {
      SidebarCommands()
      InspectorCommands()
      CommandGroup(replacing: .help) {
        let helpURL = URL(
          string:
            "https://monstar-lab-oss.github.io/reality-check/documentation/realitycheckconnect/gettingstarted"
        )!
        Link("Getting Started", destination: helpURL)
      }
    }
    .windowToolbarStyle(.automatic)
  }
}
