// This file was automatically generated and should not be edited.

import Foundation
import Models
import RealityKit

//MARK: - iOS

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
          if #available(iOS 17.0, *) {
            return AccessibilityComponent.self
          } else {
            fatalError()
          }
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

//MARK: - macOS

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

//MARK: - visionOS

extension RealityPlatform.visionOS {
  public enum ComponentType: CaseIterable {
    case accessibilityComponent
    case adaptiveResolutionComponent
    case ambientAudioComponent
    case anchoringComponent
    case audioMixGroupsComponent
    case channelAudioComponent
    case characterControllerComponent
    case characterControllerStateComponent
    case collisionComponent
    case groundingShadowComponent
    case hoverEffectComponent
    case imageBasedLightComponent
    case imageBasedLightReceiverComponent
    case inputTargetComponent
    case modelComponent
    case modelDebugOptionsComponent
    case modelSortGroupComponent
    case opacityComponent
    case particleEmitterComponent
    case perspectiveCameraComponent
    case physicsBodyComponent
    case physicsMotionComponent
    case physicsSimulationComponent
    case portalComponent
    case sceneUnderstandingComponent
    case spatialAudioComponent
    case synchronizationComponent
    case textComponent
    case transform
    case videoPlayerComponent
    case worldComponent
  }
}

#if os(visionOS)
  extension RealityPlatform.visionOS.ComponentType {
    public var rawType: RealityKit.Component.Type {
      switch self {
        case .accessibilityComponent:
          return AccessibilityComponent.self
        case .adaptiveResolutionComponent:
          return AdaptiveResolutionComponent.self
        case .ambientAudioComponent:
          return AmbientAudioComponent.self
        case .anchoringComponent:
          return AnchoringComponent.self
        case .audioMixGroupsComponent:
          return AudioMixGroupsComponent.self
        case .channelAudioComponent:
          return ChannelAudioComponent.self
        case .characterControllerComponent:
          return CharacterControllerComponent.self
        case .characterControllerStateComponent:
          return CharacterControllerStateComponent.self
        case .collisionComponent:
          return CollisionComponent.self
        case .groundingShadowComponent:
          return GroundingShadowComponent.self
        case .hoverEffectComponent:
          return HoverEffectComponent.self
        case .imageBasedLightComponent:
          return ImageBasedLightComponent.self
        case .imageBasedLightReceiverComponent:
          return ImageBasedLightReceiverComponent.self
        case .inputTargetComponent:
          return InputTargetComponent.self
        case .modelComponent:
          return ModelComponent.self
        case .modelDebugOptionsComponent:
          return ModelDebugOptionsComponent.self
        case .modelSortGroupComponent:
          return ModelSortGroupComponent.self
        case .opacityComponent:
          return OpacityComponent.self
        case .particleEmitterComponent:
          return ParticleEmitterComponent.self
        case .perspectiveCameraComponent:
          return PerspectiveCameraComponent.self
        case .physicsBodyComponent:
          return PhysicsBodyComponent.self
        case .physicsMotionComponent:
          return PhysicsMotionComponent.self
        case .physicsSimulationComponent:
          return PhysicsSimulationComponent.self
        case .portalComponent:
          return PortalComponent.self
        case .sceneUnderstandingComponent:
          return SceneUnderstandingComponent.self
        case .spatialAudioComponent:
          return SpatialAudioComponent.self
        case .synchronizationComponent:
          return SynchronizationComponent.self
        case .textComponent:
          return TextComponent.self
        case .transform:
          return Transform.self
        case .videoPlayerComponent:
          return VideoPlayerComponent.self
        case .worldComponent:
          return WorldComponent.self
      }
    }
  }
#endif
