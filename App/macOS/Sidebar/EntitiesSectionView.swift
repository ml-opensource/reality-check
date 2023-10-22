import AppFeature
import ComposableArchitecture
import SwiftUI
import RealityCodable

extension RealityPlatform.visionOS.Entity {
  public var childrenOptional: [RealityPlatform.visionOS.Entity]? {
    children.isEmpty ? nil : children.map(\.value)
  }
}

struct EntitiesSectionView: View {
  let store: StoreOf<EntitiesNavigator_visionOS>
  //TODO: @State private var searchText: String = ""

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List(
        viewStore.entities.elements,
        children: \.childrenOptional,
        selection: viewStore.$selection
      ) { entity in
        HStack {
          Label(
            entity.computedName,
            systemImage: entity.systemImage
          )

          if let children = entity.childrenOptional {
            Spacer()
            Text("\(children.count)")
              .font(.caption2)
              .padding(.vertical, 2)
              .padding(.horizontal, 6)
              .background(Capsule(style: .continuous).fill(Color(NSColor.selectedControlColor)))
          }
        }
        // FIXME: .help(entity.entityType.help)
        // .accessibilityLabel(Text(entity.accessibilityLabel ?? ""))
        // .accessibilityValue(Text(entity.accessibilityDescription ?? ""))
      }
      //TODO: .searchable(text: $searchText, placement: .sidebar)
    }
  }
}
