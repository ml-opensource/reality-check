import AppFeature
import ComposableArchitecture
import RealityCodable
import SwiftUI

//TODO: rename to `EntitiesInspector_visionOS`

struct EntityInspectorView: View {
  let store: StoreOf<EntitiesSection>
  let viewStore: ViewStoreOf<EntitiesSection>

  var entity: RealityPlatform.visionOS.Entity? {
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
          Label(
            entity.computedName,
            systemImage: entity.systemImage
          )
          .font(.headline)

          Section {
            LabeledContent(
              "id:",
              value: entity.id.description
            )

            //FIXME:
            // if let anchorIdentifier = entity.anchorIdentifier {
            //   LabeledContent(
            //     "anchorIdentifier",
            //     value: anchorIdentifier.uuidString
            //   )
            // }
          }
          .textSelection(.enabled)

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
            if let accessibilityDescription = entity.accessibilityDescription {
              LabeledContent(
                "accessibilityDescription",
                value: accessibilityDescription
              )
            }
          }

          //FIXME:
          // if !entity.availableAnimations.isEmpty {
          //   Section("Animation") {
          //     DisclosureGroup("availableAnimations") {
          //       Text(String(customDumping: entity.availableAnimations)) //FIXME: move custom dumping from this level
          //         .monospaced()
          //         .textSelection(.enabled)
          //     }
          //   }
          // }

          Section("State") {
            LabeledContent(
              "isActive",
              value: "\(entity.isAnchored ? "YES" : "NO")"
            )
            LabeledContent(
              "isAnchored",
              value:
                "\(entity.isEnabledInHierarchy ? "YES" : "NO")"
            )
            LabeledContent(
              "isEnabled",
              value: "\(entity.isEnabled ? "YES" : "NO")"
            )
            LabeledContent(
              "isEnabledInHierarchy",
              value: "\(entity.isActive ? "YES" : "NO")"
            )
            LabeledContent(
              "isOwner",
              value: "\(entity.isOwner ? "YES" : "NO")"
            )
          }

          Section("Hierarhy") {
            if let parentID = entity.parentID {
              LabeledContent(
                "parent",
                content: {
                  Button(
                    parentID.description,
                    systemImage: "arrow.up.backward",
                    action: { viewStore.send(.binding(.set(\.$selection, parentID))) }
                  )
                  .symbolVariant(.square.fill)
                  .help(
                    """
                    Click to select the parent.
                    ID: \(parentID.description)
                    """
                  )
                  .padding(1)
                }
              )
            }

            if let children = entity.childrenOptional {
              LabeledContent(
                "children count",
                value: "\(children.count)"
              )
            }
          }

          Section("Components") {
            VStack(alignment: .leading) {
              
              //TODO: Check if it makes sense to show it.
              // LabeledContent("count", value: "\(entity.components.count)")
              
              ForEach(Array(entity.components), id: \.self) { component in
                GroupBox {
                  DisclosureGroup(component.description) {
                    ComponentPropertiesView(component).monospaced()
                  }
                }
                .help(component.comment ?? "")
              }
            }
          }
        }
      }
      .textSelection(.enabled)
    }
  }
}
