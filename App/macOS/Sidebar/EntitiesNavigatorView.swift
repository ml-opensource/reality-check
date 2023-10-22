import AppFeature
import ComposableArchitecture
import RealityCodable
import SwiftUI

extension RealityPlatform.visionOS.Entity {
  public var childrenOptional: [RealityPlatform.visionOS.Entity]? {
    children.isEmpty ? nil : children.map(\.value)
  }
}

struct EntitiesNavigatorView: View {
  let store: StoreOf<EntitiesNavigator_visionOS>
  @State private var searchText: String = ""

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List(selection: viewStore.$selection) {
        Section(header: Text("Entities")) {
          OutlineGroup(
            viewStore.entities.elements,
            children: \.childrenOptional
          ) { entity in
            Label(
              entity.computedName,
              systemImage: entity.parentID == nil ? "uiwindow.split.2x1" : entity.systemImage
            )

            // FIXME: .help(entity.entityType.help)
            // .accessibilityLabel(Text(entity.accessibilityLabel ?? ""))
            // .accessibilityValue(Text(entity.accessibilityDescription ?? ""))
          }
        }
        .collapsible(false)
      }
      .searchable(text: $searchText, placement: .sidebar)
    }
  }
}
