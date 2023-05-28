import AppFeature
import ComposableArchitecture
import Models
import SwiftUI

struct Sidebar: View {
  let store: StoreOf<AppCore>
  @State private var show = false

  var body: some View {
    //TODO: implement display/selection of scenes
    // Section(
    //   content: {
    //     Text("Content")
    //   },
    //   header: {
    //     Text("Scenes").font(.headline)
    //   }
    // )

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
        Text("//TODO: Entities placeholder")
      }
    )
    .toolbar {
      ToolbarItem {
        IfLetStore(
          self.store.scope(
            state: \.arViewOptions,
            action: AppCore.Action.arViewOptions
          ),
          then: { store in
            WithViewStore(store, observe: { $0 }) { viewStore in
              Button(
                action: {
                  viewStore.send(.binding(.set(\.$isDebugOptionsDisplayed, true)))
                },
                label: { Label("Debug Options", systemImage: "ladybug") }
              )
              .controlSize(.large)
              .help("ARView Debug Options")
              .popover(
                isPresented: viewStore.binding(\.$isDebugOptionsDisplayed),
                arrowEdge: .trailing
              ) {
                DebugOptionsView(store: store)
                  .padding()
              }

            }
          },
          else: {
            Text("//TODO: ARView options placeholder")
          }
        )
      }
    }
  }
}
