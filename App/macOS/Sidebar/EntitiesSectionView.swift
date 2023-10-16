import AppFeature
import ComposableArchitecture
import SwiftUI

struct EntitiesSectionView: View {
  let store: StoreOf<EntitiesSection>
  //TODO: @State private var searchText: String = ""

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List(
        viewStore.entities.elements,
        children: \.children,
        selection: viewStore.$selection
      ) { entity in
        HStack {
          //FIXME:
          // Label(
          //   entity.name.isEmpty ? entity.entityTypeDescription : entity.name,
          //   systemImage: entity.entityTypeSystemImage
          // )

           Label(
            entity.name ?? "entity.entityTypeDescription",
             systemImage: "entity.entityTypeSystemImage"
           )

          EmptyView()
          
          if let children = entity.children, !children.isEmpty {
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
