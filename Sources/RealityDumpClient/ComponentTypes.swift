import RealityKit
import SwiftUI

// MARK: - iOS

#if os(iOS)
  // @available(iOS 17.0, *)
  let componentTypes: [Component.Type] = [
    
    // FIXME: iOS17 AccessibilityComponent.self,
    // AdaptiveResolutionComponent.self,
    // AmbientAudioComponent.self,
    
    AnchoringComponent.self,
    
    // AudioMixGroupsComponent.self,
    
    BodyTrackingComponent.self,
    
    // ChannelAudioComponent.self,
    
    CharacterControllerComponent.self,
    CharacterControllerStateComponent.self,
    CollisionComponent.self,
    DirectionalLightComponent.self,
    DirectionalLightComponent.Shadow.self,
    
    // GroundingShadowComponent.self,
    // HoverEffectComponent.self,
    // ImageBasedLightComponent.self,
    // ImageBasedLightReceiverComponent.self,
    // InputTargetComponent.self,
   
    ModelComponent.self,
    ModelDebugOptionsComponent.self,
    
    // ModelSortGroupComponent.self,
    // OpacityComponent.self,
    // ParticleEmitterComponent.self,
   
    PerspectiveCameraComponent.self,
    PhysicsBodyComponent.self,
    PhysicsMotionComponent.self,
    
    // PhysicsSimulationComponent.self,
    
    PointLightComponent.self,
    
    // PortalComponent.self,
    
    SceneUnderstandingComponent.self,
    
    // SpatialAudioComponent.self,
    
    SpotLightComponent.self,
    SpotLightComponent.Shadow.self,
    SynchronizationComponent.self,
    
    // TextComponent.self,
    
    Transform.self,
    
    // VideoPlayerComponent.self,
    // ViewAttachmentComponent.self,
    // WorldComponent.self,
    
  ]
#endif

// MARK: - visionOS

#if os(visionOS)
  let componentTypes: [Component.Type] = [
    
    AccessibilityComponent.self,
    AdaptiveResolutionComponent.self,
    AmbientAudioComponent.self,
    AnchoringComponent.self,
    AudioMixGroupsComponent.self,
    
    // BodyTrackingComponent.self,
    
    ChannelAudioComponent.self,
    CharacterControllerComponent.self,
    CharacterControllerStateComponent.self,
    CollisionComponent.self,
    
    // DirectionalLightComponent.self,
    // DirectionalLightComponent.Shadow.self,
    
    GroundingShadowComponent.self,
    HoverEffectComponent.self,
    ImageBasedLightComponent.self,
    ImageBasedLightReceiverComponent.self,
    InputTargetComponent.self,
    ModelComponent.self,
    ModelDebugOptionsComponent.self,
    ModelSortGroupComponent.self,
    OpacityComponent.self,
    ParticleEmitterComponent.self,
    PerspectiveCameraComponent.self,
    PhysicsBodyComponent.self,
    PhysicsMotionComponent.self,
    PhysicsSimulationComponent.self,
    
    // PointLightComponent.self,
    PortalComponent.self,
    SceneUnderstandingComponent.self,
    SpatialAudioComponent.self,
    
    // SpotLightComponent.self,
    // SpotLightComponent.Shadow.self,
    
    SynchronizationComponent.self,
    TextComponent.self,
    Transform.self,
    VideoPlayerComponent.self,
    ViewAttachmentComponent.self, // ← SwiftUI
    WorldComponent.self,
    
  ]
#endif

// MARK: - macOS

#if os(macOS)
  @available(macOS 14.0, *)
  let componentTypes: [Component.Type] = [
    
    AccessibilityComponent.self,
    
    // AdaptiveResolutionComponent.self,
    // AmbientAudioComponent.self,
    
    AnchoringComponent.self,
    
    // AudioMixGroupsComponent.self,
    // BodyTrackingComponent.self,
    // ChannelAudioComponent.self,
    
    CharacterControllerComponent.self,
    CharacterControllerStateComponent.self,
    CollisionComponent.self,
    DirectionalLightComponent.self,
    DirectionalLightComponent.Shadow.self,
    
    // GroundingShadowComponent.self,
    // HoverEffectComponent.self,
    // ImageBasedLightComponent.self,
    // ImageBasedLightReceiverComponent.self,
    // InputTargetComponent.self,
    
    ModelComponent.self,
    ModelDebugOptionsComponent.self,
    
    // ModelSortGroupComponent.self,
    // OpacityComponent.self,
    // ParticleEmitterComponent.self,
    
    PerspectiveCameraComponent.self,
    PhysicsBodyComponent.self,
    PhysicsMotionComponent.self,
    
    // PhysicsSimulationComponent.self,
    
    PointLightComponent.self,
    
    // PortalComponent.self,
    // SceneUnderstandingComponent.self,
    // SpatialAudioComponent.self,
    
    SpotLightComponent.self,
    SpotLightComponent.Shadow.self,
    SynchronizationComponent.self,
    
    // TextComponent.self,
    
    Transform.self,
    
    // VideoPlayerComponent.self,
    // ViewAttachmentComponent.self,
    // WorldComponent.self,
    
  ]
#endif
