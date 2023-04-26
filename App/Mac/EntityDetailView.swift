import Models
import RealityDumpClient
import SwiftUI

struct EntityDetailView: View {
    let entity: IdentifiableEntity

    var body: some View {
        List {
            Label(entity.entityType.description, systemImage: entity.entityType.symbol)
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
                LabeledContent("count", value: "\(entity.components.count)")
                ForEach(entity.components.components, id: \.self) { component in
                    GroupBox(component.componentType.description) {
                        PropertiesView(
                            componentType: component.componentType,
                            properties: component.properties
                        )
                    }
                    .help(component.componentType.help)
                }
            }
        }
    }

}

struct PropertiesView: View {
    let componentType: IdentifiableComponent.ComponentType
    let properties: ComponentPropertiesRepresentable

    var body: some View {
        switch componentType {
        case .anchoringComponent:
            AnchoringComponentPropertiesView(properties as! AnchoringComponentProperties)
        case .characterControllerComponent:
            EmptyView()
        case .characterControllerStateComponent:
            EmptyView()
        case .collisionComponent:
            EmptyView()
        case .directionalLightComponent:
            EmptyView()
        case .directionalLightComponentShadow:
            EmptyView()
        case .modelComponent:
            LabeledContent("mesh", value: "properties.mesh")
        case .modelDebugOptionsComponent:
            EmptyView()
        case .perspectiveCameraComponent:
            EmptyView()
        case .physicsBodyComponent:
            EmptyView()
        case .physicsMotionComponent:
            EmptyView()
        case .pointLightComponent:
            EmptyView()
        case .spotLightComponent:
            EmptyView()
        case .spotLightComponentShadow:
            EmptyView()
        case .synchronizationComponent:
            EmptyView()
        case .transform:
            let properties = properties as! TransformProperties
            //TODO: pretty printer
            // let prettyMatrixDescription = """
            //     [\(properties.matrix.columns.0.x), \(properties.matrix.columns.0.y), \(properties.matrix.columns.0.z), \(properties.matrix.columns.0.w)]
            // \(properties.matrix.columns.1)
            // \(properties.matrix.columns.2)
            // \(properties.matrix.columns.3)
            // """
            LabeledContent("matrix", value: properties.matrix.debugDescription)
            LabeledContent("rotation", value: properties.rotation.debugDescription)
            LabeledContent("scale", value: properties.scale.debugDescription)
            LabeledContent("translation", value: properties.translation.debugDescription)
        }
    }
}

struct AnchoringComponentPropertiesView: View {
    let properties: AnchoringComponentProperties
    private var targetDescription: String {
        switch properties.target {
        case .camera:
            return "camera"
            
        case .world(transform: let transform):
            return "world(\(transform)"
            
        @unknown default:
            return "@unknown"
        }
    }
    
    init(_ properties: AnchoringComponentProperties) {
        self.properties = properties
    }

    var body: some View {
        LabeledContent("target", value: targetDescription)
    }
}

//FIXME:
//struct EntityDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//       EntityDetailView(entity: IdentifiableEntity.mock)
//    }
//}
