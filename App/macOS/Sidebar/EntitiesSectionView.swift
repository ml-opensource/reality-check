import AppFeature
import ComposableArchitecture
import SwiftUI

struct EntitiesSectionView: View {
  let store: StoreOf<EntitiesSection>

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List(
        viewStore.identifiedEntities.elements,
        children: \._children,
        selection: viewStore.$selection
      ) { entity in
        HStack {
          if !entity.name.isEmpty {
            Label(
              title: {
                VStack(alignment: .leading) {
                  Text(entity.name)
                  //FIXME:
                  //                  Text(entity.entityType.description)
//                    .font(.caption)
//                    .foregroundColor(.secondary)
                }
              },
              icon: {
//FIXME: Image(systemName: entity.entityType.symbol)
              }
            )
          } else {
            //FIXME:
           // Label(entity.entityType.description, systemImage: entity.entityType.symbol)
          }

//          if !entity.children.isEmpty {
//            Spacer()
//            Text("\(entity.children.count)")
//              .font(.caption2)
//              .foregroundColor(.white)
//              .padding(.vertical, 2)
//              .padding(.horizontal, 6)
//              .background(Capsule(style: .continuous).fill(Color(.controlAccentColor)))
//          }
        }
        //FIXME: .help(entity.entityType.help)
//        .accessibilityLabel(Text(entity.accessibilityLabel ?? ""))
//        .accessibilityValue(Text(entity.accessibilityDescription ?? ""))
      }
    }
  }
}
