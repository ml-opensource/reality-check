import AppFeature
import ComposableArchitecture
import SwiftUI

struct EntitiesSectionView: View {
  let store: StoreOf<EntitiesSection>
  //TODO: @State private var searchText: String = ""

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List(
        viewStore.identifiedEntities.elements,
        children: \._children,
        selection: viewStore.$selection
      ) { entity in
        HStack {
          Label(
            entity.name.isEmpty ? entity.entityType.description : entity.name,
            systemImage: entity.entityType.systemImage
          )

          if !entity.children.isEmpty {
            Spacer()
            Text("\(entity.children.count)")
              .font(.caption2)
              .padding(.vertical, 2)
              .padding(.horizontal, 6)
              .background(Capsule(style: .continuous).fill(Color(NSColor.selectedControlColor)))
          }
        }
        // FIXME: .help(entity.entityType.help)
        .accessibilityLabel(Text(entity.accessibilityLabel ?? ""))
        .accessibilityValue(Text(entity.accessibilityDescription ?? ""))
      }
      //TODO: .searchable(text: $searchText, placement: .sidebar)
    }
  }
}
