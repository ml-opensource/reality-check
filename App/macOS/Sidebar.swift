import AppFeature
import ComposableArchitecture
import Models
import SwiftUI

struct Sidebar: View {
  let store: StoreOf<AppCore>
  @State private var show = false

  var body: some View {
    VStack {
      IfLetStore(
        self.store.scope(
          state: \.arViewOptions,
          action: AppCore.Action.arViewOptions
        ),
        then: { store in
          WithViewStore(store, observe: { $0 }) { viewStore in
            Section("ARView") {
              Button("Debug Options") {
                viewStore.send(.binding(.set(\.$isDebugOptionsDisplayed, true)))
              }
              .popover(
                isPresented: viewStore.binding(\.$isDebugOptionsDisplayed),
                arrowEdge: .trailing,
                content: {
                    ARViewOptionsView(store: store)
                        .padding()
                }
              )
            }
          }
        },
        else: {
          Text("TODO: ARView options placeholder")
        }
      )

      Section("Scenes") {
        Text("Scenes Content")
      }

      IfLetStore(
        self.store.scope(
          state: \.entitiesHierarchy,
          action: AppCore.Action.entitiesHierarchy
        ),
        then: { store in
          WithViewStore(store, observe: { $0 }) { viewStore in
            List(selection: viewStore.binding(\.$selection)) {
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
                        icon: { Image(systemName: entity.entityType.symbol) }
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
        },
        else: {
          Text("TODO: Entities placeholder")
        }
      )
    }
  }
}
