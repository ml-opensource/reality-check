// This file was automatically generated and should not be edited.

import Foundation
import RealityKit

#if os(iOS)

extension RealityPlatform.iOS.ComponentType {
  func makeCodable(from component: RealityKit.Component) -> RealityPlatform.iOS.Component {
    switch self {
      case .accessibilityComponent:
        return .accessibilityComponent(.init(rawValue: component))
      case .anchoringComponent:
        return .anchoringComponent(.init(rawValue: component))
      case .bodyTrackingComponent:
        return .bodyTrackingComponent(.init(rawValue: component))
      case .characterControllerComponent:
        return .characterControllerComponent(.init(rawValue: component))
      case .characterControllerStateComponent:
        return .characterControllerStateComponent(.init(rawValue: component))
      case .collisionComponent:
        return .collisionComponent(.init(rawValue: component))
      case .directionalLightComponent:
        return .directionalLightComponent(.init(rawValue: component))
      case .modelComponent:
        return .modelComponent(.init(rawValue: component))
      case .modelDebugOptionsComponent:
        return .modelDebugOptionsComponent(.init(rawValue: component))
      case .perspectiveCameraComponent:
        return .perspectiveCameraComponent(.init(rawValue: component))
      case .physicsBodyComponent:
        return .physicsBodyComponent(.init(rawValue: component))
      case .physicsMotionComponent:
        return .physicsMotionComponent(.init(rawValue: component))
      case .pointLightComponent:
        return .pointLightComponent(.init(rawValue: component))
      case .sceneUnderstandingComponent:
        return .sceneUnderstandingComponent(.init(rawValue: component))
      case .spotLightComponent:
        return .spotLightComponent(.init(rawValue: component))
      case .synchronizationComponent:
        return .synchronizationComponent(.init(rawValue: component))
      case .transform:
        return .transform(.init(rawValue: component))
    }
  }
}

#elseif os(macOS)

extension RealityPlatform.macOS.ComponentType {
  func makeCodable(from component: RealityKit.Component) -> RealityPlatform.macOS.Component {
    switch self {
      case .accessibilityComponent:
        return .accessibilityComponent(.init(rawValue: component))
      case .anchoringComponent:
        return .anchoringComponent(.init(rawValue: component))
      case .characterControllerComponent:
        return .characterControllerComponent(.init(rawValue: component))
      case .characterControllerStateComponent:
        return .characterControllerStateComponent(.init(rawValue: component))
      case .collisionComponent:
        return .collisionComponent(.init(rawValue: component))
      case .directionalLightComponent:
        return .directionalLightComponent(.init(rawValue: component))
      case .modelComponent:
        return .modelComponent(.init(rawValue: component))
      case .modelDebugOptionsComponent:
        return .modelDebugOptionsComponent(.init(rawValue: component))
      case .perspectiveCameraComponent:
        return .perspectiveCameraComponent(.init(rawValue: component))
      case .physicsBodyComponent:
        return .physicsBodyComponent(.init(rawValue: component))
      case .physicsMotionComponent:
        return .physicsMotionComponent(.init(rawValue: component))
      case .pointLightComponent:
        return .pointLightComponent(.init(rawValue: component))
      case .spotLightComponent:
        return .spotLightComponent(.init(rawValue: component))
      case .synchronizationComponent:
        return .synchronizationComponent(.init(rawValue: component))
      case .transform:
        return .transform(.init(rawValue: component))
    }
  }
}

#elseif os(visionOS)

extension RealityPlatform.visionOS.ComponentType {
  func makeCodable(from component: RealityKit.Component) -> RealityPlatform.visionOS.Component {
    switch self {
      case .accessibilityComponent:
        return .accessibilityComponent(.init(rawValue: component as! AccessibilityComponent))
      case .adaptiveResolutionComponent:
        return .adaptiveResolutionComponent(.init(rawValue: component as! AdaptiveResolutionComponent))
      case .ambientAudioComponent:
        return .ambientAudioComponent(.init(rawValue: component as! AmbientAudioComponent))
      case .anchoringComponent:
        return .anchoringComponent(.init(rawValue: component as! AnchoringComponent))
      case .audioMixGroupsComponent:
        return .audioMixGroupsComponent(.init(rawValue: component as! AudioMixGroupsComponent))
      case .channelAudioComponent:
        return .channelAudioComponent(.init(rawValue: component as! ChannelAudioComponent))
      case .characterControllerComponent:
        return .characterControllerComponent(.init(rawValue: component as! CharacterControllerComponent))
      case .characterControllerStateComponent:
        return .characterControllerStateComponent(.init(rawValue: component as! CharacterControllerStateComponent))
      case .collisionComponent:
        return .collisionComponent(.init(rawValue: component as! CollisionComponent))
      case .groundingShadowComponent:
        return .groundingShadowComponent(.init(rawValue: component as! GroundingShadowComponent))
      case .hoverEffectComponent:
        return .hoverEffectComponent(.init(rawValue: component as! HoverEffectComponent))
      case .imageBasedLightComponent:
        return .imageBasedLightComponent(.init(rawValue: component as! ImageBasedLightComponent))
      case .imageBasedLightReceiverComponent:
        return .imageBasedLightReceiverComponent(.init(rawValue: component as! ImageBasedLightReceiverComponent))
      case .inputTargetComponent:
        return .inputTargetComponent(.init(rawValue: component as! InputTargetComponent))
      case .modelComponent:
        return .modelComponent(.init(rawValue: component as! ModelComponent))
      case .modelDebugOptionsComponent:
        return .modelDebugOptionsComponent(.init(rawValue: component as! ModelDebugOptionsComponent))
      case .modelSortGroupComponent:
        return .modelSortGroupComponent(.init(rawValue: component as! ModelSortGroupComponent))
      case .opacityComponent:
        return .opacityComponent(.init(rawValue: component as! OpacityComponent))
      case .particleEmitterComponent:
        return .particleEmitterComponent(.init(rawValue: component as! ParticleEmitterComponent))
      case .perspectiveCameraComponent:
        return .perspectiveCameraComponent(.init(rawValue: component as! PerspectiveCameraComponent))
      case .physicsBodyComponent:
        return .physicsBodyComponent(.init(rawValue: component as! PhysicsBodyComponent))
      case .physicsMotionComponent:
        return .physicsMotionComponent(.init(rawValue: component as! PhysicsMotionComponent))
      case .physicsSimulationComponent:
        return .physicsSimulationComponent(.init(rawValue: component as! PhysicsSimulationComponent))
      case .portalComponent:
        return .portalComponent(.init(rawValue: component as! PortalComponent))
      case .sceneUnderstandingComponent:
        return .sceneUnderstandingComponent(.init(rawValue: component as! SceneUnderstandingComponent))
      case .spatialAudioComponent:
        return .spatialAudioComponent(.init(rawValue: component as! SpatialAudioComponent))
      case .synchronizationComponent:
        return .synchronizationComponent(.init(rawValue: component as! SynchronizationComponent))
      case .textComponent:
        return .textComponent(.init(rawValue: component as! TextComponent))
      case .transform:
        return .transform(.init(rawValue: component as! Transform))
      case .videoPlayerComponent:
        return .videoPlayerComponent(.init(rawValue: component as! VideoPlayerComponent))
      case .worldComponent:
        return .worldComponent(.init(rawValue: component as! WorldComponent))
    }
  }
}

#endif
