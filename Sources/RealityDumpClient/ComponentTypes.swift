import CustomDump
import RealityKit
import SwiftUI

#if os(iOS) && !os(visionOS)
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
    ViewAttachmentComponent.self,
    WorldComponent.self,
  ]
#endif

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

extension Entity.ComponentSet: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    var componentsInEntity: [any Component] {
      var components: [any Component] = []
      if #available(macOS 14.0, *) {
        for componentType in componentTypes {
          if self.has(componentType) {
            components.append(self[componentType]!)
          }
        }
      } else {
        // Fallback on earlier versions
      }
      return components
    }
    return .init(reflecting: componentsInEntity)
  }
}

#if os(iOS)
  @available(macOS 14.0, *)
  @available(iOS 17.0, *)
  extension RealityKit.AccessibilityComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }

  extension RealityKit.AnchoringComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }

  // FIXME: macOS
  extension RealityKit.SceneUnderstandingComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }
#endif

#if os(visionOS)
  extension RealityKit.AdaptiveResolutionComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }
#endif

#if os(iOS) && !os(visionOS)
  extension RealityKit.BodyTrackingComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }
#endif

#if os(visionOS)
  extension RealityKit.OpacityComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }
#endif

#if os(iOS)
  extension RealityKit.Transform: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }
#endif

//FIXME: Extension of protocol 'TransientComponent' cannot have an inheritance clause
// extension RealityKit.TransientComponent: CustomDumpReflectable {
//   public var customDumpMirror: Mirror {
//     .init(
//       self,
//       children: [
//         //TODO
//       ]
//     )
//   }
// }

#if os(iOS)
  extension RealityKit.SynchronizationComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }
#endif

#if os(visionOS)
  extension RealityKit.VideoPlayerComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }
#endif

#if os(iOS) && !os(visionOS)
  extension RealityKit.DirectionalLightComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }
#endif

#if os(visionOS)
  extension RealityKit.ImageBasedLightComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }

  extension RealityKit.ImageBasedLightReceiverComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }

  extension RealityKit.GroundingShadowComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }
#endif

#if os(iOS) && !os(visionOS)
  extension RealityKit.SpotLightComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }

  extension RealityKit.PointLightComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }

  //MARK: - 3D Models

  extension RealityKit.ModelComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }

  extension RealityKit.ModelDebugOptionsComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }
#endif

#if os(visionOS)
  extension RealityKit.ModelSortGroupComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }
#endif

#if os(iOS)
  extension RealityKit.CharacterControllerComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }

  extension RealityKit.CharacterControllerStateComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }
#endif

#if os(visionOS)

  // MARK: - User Interface

  extension RealityKit.HoverEffectComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }

  extension RealityKit.PortalComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }

  extension RealityKit.WorldComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }

  extension RealityKit.InputTargetComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }

  extension RealityKit.TextComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }

  extension RealityKit.ViewAttachmentComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }

  // MARK: - Sound

  extension RealityKit.AmbientAudioComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }

  extension RealityKit.AudioMixGroupsComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }

  extension RealityKit.ChannelAudioComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }

  extension RealityKit.SpatialAudioComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }
#endif

// MARK: - Simulations

#if os(iOS)
  extension RealityKit.CollisionComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }

  extension RealityKit.PhysicsBodyComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }

  extension RealityKit.PhysicsMotionComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }
#endif

#if os(visionOS)
  extension RealityKit.PhysicsSimulationComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }

  extension RealityKit.ParticleEmitterComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }
#endif

#if os(iOS)
  extension RealityKit.PerspectiveCameraComponent: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      .init(
        self,
        children: [
          //TODO
        ]
      )
    }
  }
#endif
