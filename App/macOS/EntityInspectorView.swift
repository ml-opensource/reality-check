import AppFeature
import ComposableArchitecture
import RealityCodable
import SwiftUI

struct EntityInspectorView: View {
  let store: StoreOf<EntitiesSection>
  let viewStore: ViewStoreOf<EntitiesSection>

  var entity: _CodableEntity? {
    viewStore.selectedEntity
  }

  init(
    _ store: StoreOf<EntitiesSection>
  ) {
    self.store = store
    self.viewStore = .init(store, observe: { $0 })
  }

  var body: some View {
    if let entity {
      VStack(alignment: .leading, spacing: 0) {
        VStack(alignment: .leading) {
          //FIXME:
          // Label(
          //   entity.entityType.description,
          //   systemImage: entity.entityType.symbol
          // )
          // .font(.headline)

          Section {
            LabeledContent(
              "id:",
              value: entity.id.description
            )
            .textSelection(.enabled)

            if !entity.name.isEmpty {
              LabeledContent(
                "name:",
                value: entity.name
              )
            }
            //FIXME:
            // if let anchorIdentifier = entity.anchorIdentifier {
            //   LabeledContent(
            //     "anchorIdentifier",
            //     value: anchorIdentifier.uuidString
            //   )
            // }
          }
        }
        .padding()

        Divider()

        List {
          Section("Accessibility") {
            LabeledContent(
              "isAccessibilityElement",
              value:
                "\(entity.isAccessibilityElement ? "YES" : "NO")"
            )
            if let accessibilityLabel = entity.accessibilityLabel {
              LabeledContent(
                "accessibilityLabel",
                value: accessibilityLabel
              )
            }
            if let accessibilityDescription = entity
              .accessibilityDescription
            {
              LabeledContent(
                "accessibilityDescription",
                value: accessibilityDescription
              )
            }
          }

          if !entity.availableAnimations.isEmpty {
            Section("Animation") {
              DisclosureGroup("availableAnimations") {
                Text(String(customDumping: entity.availableAnimations))
                  .monospaced()
                  .textSelection(.enabled)
              }
            }
          }

          Section("State") {
            LabeledContent(
              "isEnabled",
              value: "\(entity.isEnabled ? "YES" : "NO")"
            )
            LabeledContent(
              "isEnabledInHierarchy",
              value: "\(entity.isActive ? "YES" : "NO")"
            )
            LabeledContent(
              "isAnchored",
              value:
                "\(entity.isEnabledInHierarchy ? "YES" : "NO")"
            )
            LabeledContent(
              "isActive",
              value: "\(entity.isAnchored ? "YES" : "NO")"
            )
          }
//FIXME:
//          Section("Hierarhy") {
//            if let parentID = entity.hierarhy.parentID {
//              LabeledContent(
//                "parent",
//                content: {
//                  Button(
//                    parentID.description,
//                    systemImage: "arrow.up.forward.square.fill",
//                    action: { viewStore.send(.binding(.set(\.$selection, parentID))) }
//                  )
//                  .help(
//                    """
//                    Click to select the parent.
//                    ID: \(parentID.description)
//                    """
//                  )
//                  .padding(1)
//                }
//              )
//            }
//            LabeledContent(
//              "children count",
//              value: "\(entity.hierarhy.childrenCount)"
//            )
//          }

          //FIXME:
//          Section("Components") {
//            LabeledContent("count", value: "\(entity.components.count)")
//            ForEach(entity.components.components, id: \.self) { component in
//              GroupBox {
//                DisclosureGroup(component.componentType.description) {
//                  ComponentPropertiesView(component.properties)
//                    .monospaced()
//                }
//                .help(component.componentType.help)
//              }
//            }
//          }
        }
      }
      .textSelection(.enabled)
    }
  }
}
