// This file was automatically generated and should not be edited.

import Foundation
import RealityKit

//MARK: macOS

extension RealityPlatform.macOS {
    public enum ComponentType: CaseIterable {
        case accessibilityComponent
        case anchoringComponent
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
        case spotLightComponent
        case synchronizationComponent
        case transform
    }
}
#if os(macOS)
extension RealityPlatform.macOS.ComponentType {
    public var rawType: RealityKit.Component.Type {
        switch self {
        case .accessibilityComponent:
          if #available(macOS 14.0, *) {
            return AccessibilityComponent.self
          } else {
            fatalError()
          }
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
        case .synchronizationComponent:
          return SynchronizationComponent.self
        case .transform:
          return Transform.self
        }
    }
}
#endif
