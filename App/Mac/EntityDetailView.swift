import Models
import RealityDumpClient
import SwiftUI

struct EntityDetailView: View {
    let entity: IdentifiableEntity

    var body: some View {
        List {
            Label(entity.type.description, systemImage: entity.type.symbol)
                .font(.headline)

            Section {
                if let name = entity.name, !name.isEmpty {
                    LabeledContent("name:", value: name)
                }
                if let anchorIdentifier = entity.anchorIdentifier {
                    LabeledContent("anchorIdentifier", value: anchorIdentifier.uuidString)
                }
                LabeledContent("id:", value: entity.id.description)
            }

            Section("State") {
                LabeledContent("isEnabled", value: "\(entity.state.isEnabled ? "YES" : "NO")")
                LabeledContent(
                    "isEnabledInHierarchy", value: "\(entity.state.isActive ? "YES" : "NO")")
                LabeledContent(
                    "isAnchored", value: "\(entity.state.isEnabledInHierarchy ? "YES" : "NO")")
                LabeledContent("isActive", value: "\(entity.state.isAnchored ? "YES" : "NO")")
            }

            Section("Hierarhy") {
                LabeledContent("parent", value: "\(entity.hierarhy.hasParent ? "YES" : "NO")")
                LabeledContent("children count", value: "\(entity.hierarhy.childrenCount)")
            }

            Section("Components") {
                LabeledContent("count", value: "\(entity.components.componentsCount)")
            }
        }
    }
}

struct EntityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EntityDetailView(entity: IdentifiableEntity.mock)
    }
}
