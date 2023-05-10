import AppFeature
import ComposableArchitecture
import SwiftUI

struct Sidebar: View {
  @ObservedObject var viewStore: ViewStoreOf<AppCore>

  var body: some View {
    List(selection: viewStore.binding(\.$selected)) {
      Section("ARView") {}
      Section("Scenes") {}
      Section("Entities") {
        OutlineGroup(viewStore.identifiedEntities, children: \.children) { entity in
          NavigationLink(
            value: entity,
            label: {
              if let name = entity.name,
                !name.isEmpty
              {
                Label(
                  title: {
                    VStack(alignment: .leading) {
                      Text(name)
                      Text(entity.entityType.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                  },
                  icon: { Image(systemName: entity.entityType.symbol) }
                )
              } else {
                Label(entity.entityType.description, systemImage: entity.entityType.symbol)
                  .help(entity.entityType.help)
              }
            }
          )
          .help(entity.entityType.help)
          .accessibilityLabel(Text(entity.accessibilityLabel ?? ""))
          .accessibilityValue(Text(entity.accessibilityDescription ?? ""))
        }
      }
    }
  }
}
