import ComposableArchitecture
import Models
import SwiftUI

struct Inspector_iOS: View {
  @State var store: StoreOf<EntitiesNavigator_iOS>

  var entity: RealityPlatform.iOS.Entity? {
    store.selectedEntity
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
        }
        .padding()

        Divider()

        Form {
          Section("􀕾 Accessibility") {
            LabeledContent(
              "isAccessibilityElement",
              content: {
                Toggle("isAccessibilityElement", isOn: .constant(entity.isAccessibilityElement))
                  .labelsHidden()
                  .disabled(true)
              }
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

          Section("􀊞 State") {
            LabeledContent(
              "isActive",
              content: {
                Toggle("isActive", isOn: .constant(entity.isAnchored)).labelsHidden().disabled(true)
              }
            )
            LabeledContent(
              "isAnchored",
              content: {
                Toggle("isAnchored", isOn: .constant(entity.isAnchored)).labelsHidden()
                  .disabled(true)
              }
            )
            LabeledContent(
              "isEnabled",
              content: {
                Toggle("isEnabled", isOn: .constant(entity.isEnabled)).labelsHidden().disabled(true)
              }
            )
            LabeledContent(
              "isEnabledInHierarchy",
              content: {
                Toggle("isEnabledInHierarchy", isOn: .constant(entity.isEnabledInHierarchy))
                  .labelsHidden().disabled(true)
              }
            )
            LabeledContent(
              "isOwner",
              content: {
                Toggle("isOwner", isOn: .constant(entity.isOwner)).labelsHidden().disabled(true)
              }
            )
          }

          Section("􁀘 Hierarhy") {
            if let parentID = entity.parentID {
              LabeledContent(
                "parent",
                content: {
                  Button(
                    parentID.description,
                    systemImage: "arrow.up.backward",
                    action: { store.send(.binding(.set(\.selection, parentID))) }
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

          Section("􁏮 Components") {
            ForEach(Array(entity.components), id: \.self) { component in
              if let reflectedDescription = component.reflectedDescription {
                GroupBox {
                  Text(reflectedDescription)
                    .padding(8)
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