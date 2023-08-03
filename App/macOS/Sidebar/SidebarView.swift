import AppFeature
import ComposableArchitecture
import Models
import SwiftUI

struct SidebarView: View {
  let store: StoreOf<AppCore>

  var body: some View {
//    VStack(spacing: 0) {
//
//      //MARK: ARView & Scenes
//      IfLetStore(
//        self.store.scope(
//          state: \.arViewSection,
//          action: AppCore.Action.arViewSection
//        ),
//        then: ARViewSectionView.init(store:),
//        else: { Text("//TODO: ARView options placeholder") }
//      )

      //MARK: Entities
      IfLetStore(
        self.store.scope(
          state: \.entitiesSection,
          action: AppCore.Action.entitiesSection
        ),
        then: EntitiesSectionView.init(store:),
        else: { Text("//TODO: Entities placeholder") }
      )
//    }
  }
}
