import AppFeature
import ComposableArchitecture
import Models
import SwiftUI

struct NavigatorView: View {
  let store: StoreOf<AppCore>

  var body: some View {
    VStack {
      //MARK: ARView & Scenes

      //FIXME: restore
      // IfLetStore(
      //   self.store.scope(
      //     state: \.arViewSection,
      //     action: AppCore.Action.arViewSection
      //   ),
      //   then: ARViewSectionView.init(store:)
      // )

      //MARK: Entities

      IfLetStore(
        self.store.scope(
          state: \.entitiesSection,
          action: AppCore.Action.entitiesNavigator
        ),
        then: EntitiesSectionView.init(store:),
        else: { Text("No Entities").foregroundStyle(.secondary) }
      )
    }
  }
}
