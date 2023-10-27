import CustomDump
import RealityKit

#if os(iOS)

// MARK: - iOS

extension AccessibilityComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension AnchoringComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension BodyTrackingComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension CharacterControllerComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension CharacterControllerStateComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension CollisionComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension DirectionalLightComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension DirectionalLightComponent.Shadow: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension ModelComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension ModelDebugOptionsComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension PerspectiveCameraComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension PhysicsBodyComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension PhysicsMotionComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension PointLightComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension SceneUnderstandingComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension SpotLightComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension SpotLightComponent.Shadow: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension SynchronizationComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension Transform: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}

#elseif os(macOS)

// MARK: - macOS

@available(macOS 14.0, *)
extension AccessibilityComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension AnchoringComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension CharacterControllerComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension CharacterControllerStateComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension CollisionComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension DirectionalLightComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension DirectionalLightComponent.Shadow: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension ModelComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension ModelDebugOptionsComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension PerspectiveCameraComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension PhysicsBodyComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension PhysicsMotionComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension PointLightComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension SpotLightComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension SpotLightComponent.Shadow: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension SynchronizationComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension Transform: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}

#elseif os(visionOS)

// MARK: - visionOS

extension AccessibilityComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension AdaptiveResolutionComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension AmbientAudioComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension AnchoringComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension AudioMixGroupsComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension ChannelAudioComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension CharacterControllerComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension CharacterControllerStateComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension CollisionComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension GroundingShadowComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension HoverEffectComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension ImageBasedLightComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension ImageBasedLightReceiverComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension InputTargetComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension ModelComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension ModelDebugOptionsComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension ModelSortGroupComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension OpacityComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension ParticleEmitterComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension PerspectiveCameraComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension PhysicsBodyComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension PhysicsMotionComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension PhysicsSimulationComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension PortalComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension SceneUnderstandingComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension SpatialAudioComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension SynchronizationComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension TextComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension Transform: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension VideoPlayerComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}
extension WorldComponent: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(reflecting: self)
  }
}

#endif
