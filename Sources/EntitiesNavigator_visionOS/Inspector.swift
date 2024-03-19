import ComposableArchitecture
import Models
import SwiftUI

public struct Inspector_visionOS: View {
  let store: StoreOf<EntitiesNavigator_visionOS>

  var entity: RealityPlatform.visionOS.Entity? {
    store.selectedEntity
  }

  public init(store: StoreOf<EntitiesNavigator_visionOS>) {
    self.store = store
  }

  public var body: some View {
    if let entity {
      Form {
        LabeledContent(
          "ID",
          value: entity.id.description
        )

        Section {
          LabeledContent(
            "isAccessibilityElement",
            value: entity.isAccessibilityElement ? "YES" : "NO"
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
        } header: {
          Label("Accessibility", systemImage: "accessibility")
        }
        .accessibilityLabel("Accessibility")

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

        Section {
          LabeledContent("isActive", value: entity.isActive ? "YES" : "NO")
          LabeledContent("isAnchored", value: entity.isAnchored ? "YES" : "NO")
          LabeledContent("isEnabled", value: entity.isEnabled ? "YES" : "NO")
          LabeledContent("isEnabledInHierarchy", value: entity.isEnabledInHierarchy ? "YES" : "NO")
          LabeledContent("isOwner", value: entity.isOwner ? "YES" : "NO")
        } header: {
          Label(
            "State",
            systemImage: "slider.horizontal.2.rectangle.and.arrow.triangle.2.circlepath"
          )
        }

        Section {
          if let parentID = entity.parentID {
            LabeledContent(
              "parent",
              content: {
                Button(
                  parentID.description,
                  systemImage: "arrow.up.backward",
                  action: { store.selection = parentID }
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
        } header: {
          Label("Hierarhy", systemImage: "app.connected.to.app.below.fill")
        }

        Section {
          ForEach(Array(entity.components), id: \.self) { component in
            if let reflectedDescription = component.reflectedDescription {
              Text(reflectedDescription)
                .monospaced()
                .padding(8)
                .help(component.comment ?? "")
            }
          }
        } header: {
          Label("Components", systemImage: "switch.programmable")
        }
      }
      .textSelection(.enabled)
      .navigationTitle(entity.computedName)
      .listStyle(.plain)
    }
  }
}
