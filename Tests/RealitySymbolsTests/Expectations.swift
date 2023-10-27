import Foundation

// MARK: - All

var allComponents: [String] {
  Set(expectedComponents_iOS + expectedComponents_macOS + expectedComponents_xrOS).sorted()
}

// MARK: - iOS

let expectedComponents_iOS = [
  "AccessibilityComponent",
  "AnchoringComponent",
  "BodyTrackingComponent",
  "CharacterControllerComponent",
  "CharacterControllerStateComponent",
  "CollisionComponent",
  "DirectionalLightComponent",
  "DirectionalLightComponent.Shadow",
  "ModelComponent",
  "ModelDebugOptionsComponent",
  "PerspectiveCameraComponent",
  "PhysicsBodyComponent",
  "PhysicsMotionComponent",
  "PointLightComponent",
  "SceneUnderstandingComponent",
  "SpotLightComponent",
  "SpotLightComponent.Shadow",
  "SynchronizationComponent",
  "Transform",
]

// Exclusive components from iOS
let exclusiveComponents_iOS = [
  "BodyTrackingComponent"
]

/// Components that are available in iOS, but not on macOS.
let substractedComponents_iOS_macOS = [
  "BodyTrackingComponent",
  "SceneUnderstandingComponent",
]

/// Components that are available in iOS, but not on xrOS.
let substractedComponents_iOS_xrOS = [
  "BodyTrackingComponent",
  "DirectionalLightComponent",
  "DirectionalLightComponent.Shadow",
  "PointLightComponent",
  "SpotLightComponent",
  "SpotLightComponent.Shadow",
]

// MARK: - macOS

let expectedComponents_macOS = [
  "AccessibilityComponent",
  "AnchoringComponent",
  "CharacterControllerComponent",
  "CharacterControllerStateComponent",
  "CollisionComponent",
  "DirectionalLightComponent",
  "DirectionalLightComponent.Shadow",
  "ModelComponent",
  "ModelDebugOptionsComponent",
  "PerspectiveCameraComponent",
  "PhysicsBodyComponent",
  "PhysicsMotionComponent",
  "PointLightComponent",
  "SpotLightComponent",
  "SpotLightComponent.Shadow",
  "SynchronizationComponent",
  "Transform",
]

// Exclusive components from macOS
let exclusiveComponents_macOS: [String] = []

/// Components that are available in macOS, but not on xrOS.
let substractedComponents_macOS_xrOS = [
  "DirectionalLightComponent",
  "DirectionalLightComponent.Shadow",
  "PointLightComponent",
  "SpotLightComponent",
  "SpotLightComponent.Shadow",
]

// MARK: - visionOS

let expectedComponents_xrOS = [
  "AccessibilityComponent",
  "AdaptiveResolutionComponent",
  "AmbientAudioComponent",
  "AnchoringComponent",
  "AudioMixGroupsComponent",
  "ChannelAudioComponent",
  "CharacterControllerComponent",
  "CharacterControllerStateComponent",
  "CollisionComponent",
  "GroundingShadowComponent",
  "HoverEffectComponent",
  "ImageBasedLightComponent",
  "ImageBasedLightReceiverComponent",
  "InputTargetComponent",
  "ModelComponent",
  "ModelDebugOptionsComponent",
  "ModelSortGroupComponent",
  "OpacityComponent",
  "ParticleEmitterComponent",
  "PerspectiveCameraComponent",
  "PhysicsBodyComponent",
  "PhysicsMotionComponent",
  "PhysicsSimulationComponent",
  "PortalComponent",
  "SceneUnderstandingComponent",
  "SpatialAudioComponent",
  "SynchronizationComponent",
  "TextComponent",
  "Transform",
  "VideoPlayerComponent",
  "WorldComponent",
]

let exclusiveComponents_xrOS = [
  "AdaptiveResolutionComponent",
  "AmbientAudioComponent",
  "AudioMixGroupsComponent",
  "ChannelAudioComponent",
  "GroundingShadowComponent",
  "HoverEffectComponent",
  "ImageBasedLightComponent",
  "ImageBasedLightReceiverComponent",
  "InputTargetComponent",
  "ModelSortGroupComponent",
  "OpacityComponent",
  "ParticleEmitterComponent",
  "PhysicsSimulationComponent",
  "PortalComponent",
  "SpatialAudioComponent",
  "TextComponent",
  "VideoPlayerComponent",
  "WorldComponent",
]
