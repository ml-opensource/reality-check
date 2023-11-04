// This file was automatically generated and should not be edited.

import Foundation
import RealityKit

//MARK: iOS

extension RealityPlatform.iOS {
    public enum ComponentType: CaseIterable {
        case accessibilityComponent
        case anchoringComponent
        case bodyTrackingComponent
        case characterControllerComponent
        case characterControllerStateComponent
        case collisionComponent
        case directionalLightComponent
        case modelComponent
        case modelDebugOptionsComponent
        case perspectiveCameraComponent
        case physicsBodyComponent
        case physicsMotionComponent
        case pointLightComponent
        case sceneUnderstandingComponent
        case spotLightComponent
        case synchronizationComponent
        case transform
    }
}
#if os(iOS)
extension RealityPlatform.iOS.ComponentType {
    public var rawType: RealityKit.Component.Type {
        switch self {
        case .accessibilityComponent:
          return AccessibilityComponent.self
        case .anchoringComponent:
          return AnchoringComponent.self
        case .bodyTrackingComponent:
          return BodyTrackingComponent.self
        case .characterControllerComponent:
          return CharacterControllerComponent.self
        case .characterControllerStateComponent:
          return CharacterControllerStateComponent.self
        case .collisionComponent:
          return CollisionComponent.self
        case .directionalLightComponent:
          return DirectionalLightComponent.self
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
        case .sceneUnderstandingComponent:
          return SceneUnderstandingComponent.self
        case .spotLightComponent:
          return SpotLightComponent.self
        case .synchronizationComponent:
          return SynchronizationComponent.self
        case .transform:
          return Transform.self
        }
    }
}
#endif