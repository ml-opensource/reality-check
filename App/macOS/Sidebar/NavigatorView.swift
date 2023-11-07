import AppFeature
import ComposableArchitecture
import Models
import SwiftUI

struct NavigatorView: View {
  let store: StoreOf<AppCore>

  var body: some View {
    // VStack {
    //MARK: ARView & Scenes

    //FIXME: restore
    // IfLetStore(
    //   self.store.scope(
    //     state: \.arViewSection,
    //     action: AppCore.Action.arViewSection
    //   ),
    //   then: ARViewSectionView.init(store:)
    // )

    //MARK: Entities navigator

    //FIXME: make specialized iOS `EntitiesNavigatorView`
    // IfLetStore(
    //   self.store.scope(state: \.$entitiesNavigator, action: { .entitiesNavigator($0) }),
    //   state: /EntitiesNavigator.State.iOS,
    //   action: EntitiesNavigator.Action.iOS,
    //   then: EntitiesNavigatorView.init(store:),
    //   else: { EmptyNavigatorView() }
    // )

    IfLetStore(
      self.store.scope(state: \.$entitiesNavigator, action: { .entitiesNavigator($0) }),
      state: /EntitiesNavigator.State.visionOS,
      action: EntitiesNavigator.Action.visionOS,
      then: EntitiesNavigatorView.init(store:),
      else: EmptyNavigatorView.init
    )

    // }
  }
}

struct EmptyNavigatorView: View {
  var body: some View {
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
