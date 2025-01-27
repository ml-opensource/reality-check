import AppFeature
import ComposableArchitecture
import SwiftUI

struct EntitiesSectionView: View {
  let store: StoreOf<EntitiesSection>

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List(selection: viewStore.$selection) {
        Section("Entities") {
          OutlineGroup(
            viewStore.identifiedEntities.elements,
            children: \.children
          ) { entity in
            HStack {
              if let name = entity.name, !name.isEmpty {
                Label(
                  title: {
                    VStack(alignment: .leading) {
                      Text(name)
                      Text(entity.entityType.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                  },
                  icon: {
                    Image(systemName: entity.entityType.symbol)
                  }
                )
              } else {
                Label(entity.entityType.description, systemImage: entity.entityType.symbol)
              }

              if let children = entity.children {
                Spacer()
                Text("\(children.count)")
                  .font(.caption2)
                  .foregroundColor(.white)
                  .padding(.vertical, 2)
                  .padding(.horizontal, 6)
                  .background(Capsule(style: .continuous).fill(Color(.controlAccentColor)))
              }
            }
            .help(entity.entityType.help)
            .accessibilityLabel(Text(entity.accessibilityLabel ?? ""))
            .accessibilityValue(Text(entity.accessibilityDescription ?? ""))
          }
        }
      }
    }
  }
}
