import AppFeature
import ComposableArchitecture
import SwiftUI

struct NavigatorView: View {
  let store: StoreOf<AppCore>

  var body: some View {
    IfLetStore(self.store.scope(state: \.$entitiesNavigator, action: { .entitiesNavigator($0) })) {
      store in
      SwitchStore(store) { state in
        switch state {
          case .iOS:
            CaseLet(/EntitiesNavigator.State.iOS, action: EntitiesNavigator.Action.iOS) { store in
              EntitiesNavigatorView_iOS(store: store)
            }
          case .visionOS:
            CaseLet(/EntitiesNavigator.State.visionOS, action: EntitiesNavigator.Action.visionOS) {
              store in
              EntitiesNavigatorView_visionOS(store: store)
            }
        }
      }
    } else: {
      if #available(macOS 14.0, *) {
        ContentUnavailableView(
          "No Entities",
          systemImage: "move.3d",
          description: Text("Connect to an inspectable app to examine its hierarchy")
        )
      } else {
        Text("No Entities").foregroundStyle(.secondary)
      }
    }
  }
}
