import Foundation
import RealityKit

protocol ComponentRepresentable {}

struct AnchoringComponentRepresentable: ComponentRepresentable {}
struct CharacterControllerComponentRepresentable: ComponentRepresentable {}

public struct IdentifiableComponent: Equatable, Hashable {

    //TODO: include TransientComponent.self
    public enum ComponentType: CaseIterable, RawRepresentable {
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

        public var rawValue: Component.Type {
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
            }
        }

        public init?(rawValue: Component.Type) {
            for componentType in Self.allCases {
                if componentType.rawValue == rawValue {
                    self = componentType
                    return
                }
            }
            //TODO: handle unknown components
            fatalError("Unknown Component.Type")
        }
    }

    public let componentType: ComponentType

    public init(_ component: RealityKit.Component) {
        //FIXME: handle errors
        self.componentType = .init(rawValue: type(of: component))!
    }
}

extension IdentifiableComponent.ComponentType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .anchoringComponent:
            return "AnchoringComponent"

        case .characterControllerComponent:
            return "CharacterControllerComponent"

        case .characterControllerStateComponent:
            return "CharacterControllerStateComponent"

        case .collisionComponent:
            return "CollisionComponent"

        case .directionalLightComponent:
            return "DirectionalLightComponent"

        case .directionalLightComponentShadow:
            return "DirectionalLightComponent.Shadow"

        case .modelComponent:
            return "ModelComponent"

        case .modelDebugOptionsComponent:
            return "ModelDebugOptionsComponent"

        case .perspectiveCameraComponent:
            return "PerspectiveCameraComponent"

        case .physicsBodyComponent:
            return "PhysicsBodyComponent"

        case .physicsMotionComponent:
            return "PhysicsMotionComponent"

        case .pointLightComponent:
            return "PointLightComponent"

        case .spotLightComponent:
            return "SpotLightComponent"

        case .spotLightComponentShadow:
            return "SpotLightComponent.Shadow"

        case .synchronizationComponent:
            return "SynchronizationComponent"

        case .transform:
            return "Transform"
        }
    }
}
