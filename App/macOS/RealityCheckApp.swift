import AppFeature
import ComposableArchitecture
import SwiftUI

@main
struct RealityCheckApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView(
        store: .init(
          initialState: AppCore.State(),
          reducer: AppCore()
            .dependency(\.multipeerClient, .previewValue)
        )
      )
    }
  }
}
