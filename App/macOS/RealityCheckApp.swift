import AppFeature
import ComposableArchitecture
import SwiftUI

@main
struct RealityCheckApp: App {
  let store: StoreOf<AppCore> = .init(
    initialState: AppCore.State(),
    reducer: { AppCore() }
      // .dependency(\.multipeerClient, .testValue)
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

    Window("RealityCheck", id: "RealityCheckWindowID") {
      MainView(store: store)
    }
  }
}
