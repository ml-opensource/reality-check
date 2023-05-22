import Models
import SwiftUI

struct EntityDetailView: View {
  let entity: IdentifiableEntity

  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      VStack(alignment: .leading) {
        Label(
          entity.entityType.description,
          systemImage: entity.entityType.symbol
        )
        .font(.title)

        Section {
          LabeledContent(
            "id:",
            value: entity.id.description
          )
          .textSelection(.enabled)

          if let name = entity.name, !name.isEmpty {
            LabeledContent(
              "name:",
              value: name
            )
            .textSelection(.enabled)
          }

          if let anchorIdentifier = entity.anchorIdentifier {
            LabeledContent(
              "anchorIdentifier",
              value: anchorIdentifier.uuidString
            )
            .textSelection(.enabled)
          }
        }
      }
      .padding()

      Divider()

      Form {
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

        Section("State") {
          LabeledContent(
            "isEnabled",
            value: "\(entity.state.isEnabled ? "YES" : "NO")"
          )
          LabeledContent(
            "isEnabledInHierarchy",
            value: "\(entity.state.isActive ? "YES" : "NO")"
          )
          LabeledContent(
            "isAnchored",
            value:
              "\(entity.state.isEnabledInHierarchy ? "YES" : "NO")"
          )
          LabeledContent(
            "isActive",
            value: "\(entity.state.isAnchored ? "YES" : "NO")"
          )
        }

        Section("Hierarhy") {
          LabeledContent(
            "parent",
            value: "\(entity.hierarhy.hasParent ? "YES" : "NO")"
          )
          LabeledContent(
            "children count",
            value: "\(entity.hierarhy.childrenCount)"
          )
        }
      

        Section("Components") {
          LabeledContent("count", value: "\(entity.components.count)")
          ForEach(entity.components.components, id: \.self) { component in
            DisclosureGroup(component.componentType.description) {
              ComponentPropertiesView(component.properties)
                .monospaced()
            }
            .help(component.componentType.help)
          }
        }
      }
      .formStyle(.grouped)
    }
  }
}
