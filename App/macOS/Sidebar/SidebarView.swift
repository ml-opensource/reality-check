import AppFeature
import ComposableArchitecture
import Models
import SwiftUI

struct SidebarView: View {
  let store: StoreOf<AppCore>
  @State private var show = false

  var body: some View {
    VStack(spacing: 0) {
      IfLetStore(
        self.store.scope(
          state: \.arViewOptions,
          action: AppCore.Action.arViewOptions
        ),
        then: { store in
          ARViewSectionView(store: store)
        },
        else: {
          Text("//TODO: ARView options placeholder")
        }
      )

      IfLetStore(
        self.store.scope(
          state: \.entitiesHierarchy,
          action: AppCore.Action.entitiesHierarchy
        ),
        then: { store in
          EntitiesSectionView(store: store)
        },
        else: {
          Text("//TODO: Entities placeholder")
        }
      )
    }
  }
}
