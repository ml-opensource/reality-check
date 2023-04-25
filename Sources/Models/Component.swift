import Foundation
import RealityKit

protocol ComponentRepresentable { }

struct AnchoringComponentRepresentable: ComponentRepresentable {}
struct CharacterControllerComponentRepresentable: ComponentRepresentable {}

public struct IdentifiableComponent {
    //TODO: include TransientComponent.self
    enum ComponentType: CaseIterable {
        case anchoringComponent
        case characterControllerComponent
        case characterControllerStateComponent
        case collisionComponent
        case directionalLightComponent
        case directionalLightComponentShadow
        case modelComponent
        case modelDebugOptionsComponent
        case perspectiveCameraComponent
        case physicsBodyComponent
        case physicsMotionComponent
        case pointLightComponent
        case spotLightComponent
        case spotLightComponentShadow
        case synchronizationComponent
        case transform

        var componentType: Component.Type {
            switch self {
            case .anchoringComponent:
                return AnchoringComponent.self

            case .characterControllerComponent:
                return CharacterControllerComponent.self

            case .characterControllerStateComponent:
                return CharacterControllerStateComponent.self

            case .collisionComponent:
                return CollisionComponent.self

            case .directionalLightComponent:
                return DirectionalLightComponent.self

            case .directionalLightComponentShadow:
                return DirectionalLightComponent.Shadow.self

            case .modelComponent:
                return ModelComponent.self

            case .modelDebugOptionsComponent:
                return ModelDebugOptionsComponent.self

            case .perspectiveCameraComponent:
                return PerspectiveCameraComponent.self

            case .physicsBodyComponent:
                return PhysicsBodyComponent.self

            case .physicsMotionComponent:
                return PhysicsMotionComponent.self

            case .pointLightComponent:
                return PointLightComponent.self

            case .spotLightComponent:
                return SpotLightComponent.self

            case .spotLightComponentShadow:
                return SpotLightComponent.Shadow.self

            case .synchronizationComponent:
                return SynchronizationComponent.self

            case .transform:
                return Transform.self

            //TODO: handle unknown components
            // @unknown default:
            //     fatalError("Unknown Component.Type")
            }
        }
    }
}
