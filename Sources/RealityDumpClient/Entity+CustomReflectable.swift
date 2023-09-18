import CustomDump
import RealityKit
import SwiftUI


extension RealityKit.Entity: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(
      self,
      children: [
        /// Identity
        "scene": self.scene?.name,
        "name": self.name,
        "id": self.id,
        
        /// State
        "isEnabled": self.isEnabled,
        "isEnabledInHierarchy": self.isEnabledInHierarchy,
        "isActive": self.isActive,
        "isAnchored": self.isAnchored,
        
        /// Hierarchy
        "parentID": self.parent?.id,
        "children": self.children.map({ $0 }),
        
        ///Components
        "components": self.components,
        
        /// Synchronization
        //TODO: "synchronization": self.synchronization,
        //TODO: "isOwner": self.isOwner,
        
        ///Nearest Anchor
        //TODO: "anchor": self.anchor,
        
        ///Animations
        // "availableAnimations": self.availableAnimations,
        
        ///Animating an Entity
        //TODO: "defaultAnimationClock": self.defaultAnimationClock,
        //TODO: "bindableValues": self.bindableValues,
        //TODO: "parameters": self.parameters,
        
        ///Animating and Controlling Characters
        //TODO: "characterController": self.characterController,
        //TODO: "characterControllerState": self.characterControllerState,
        
        ///Accessibility
        "isAccessibilityElement": self.isAccessibilityElement,

          //TODO: Instance Properties
      ],
      displayStyle: .struct
    )
  }
}

extension RealityKit.AnimationResource: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(
      self,
      children: [
        "name": self.name,
        "definition": self.definition,
      ]
    )
  }
}

//TODO: describe the conforming types of AnimationDefinition
//https://developer.apple.com/documentation/realitykit/animationdefinition
//AnimationGroup
//AnimationView
//BlendTreeAnimation
//FromToByAnimation
//OrbitAnimation
//SampledAnimation
//extension RealityKit.AnimationDefinition: CustomDumpReflectable {
//  public var customDumpMirror: Mirror {
//    .init(
//      self,
//      children: [
//        "name": self.name,
//        "bindTarget": self.bindTarget,
//        "blendLayer": self.blendLayer,
//        "speed": self.speed,
//        "delay": self.delay,
//        "duration": self.duration,
//        "offset": self.offset,
//        "trimDuration": self.trimDuration,
//        "trimStart": self.trimStart,
//        "trimEnd": self.trimEnd,
//      ]
//    )
//  }
//}


#if os(iOS) || os(visionOS)
  extension Entity.ComponentSet: CustomDumpReflectable {
    public var customDumpMirror: Mirror {
      var componentsInEntity: [any Component] {
        var components: [any Component] = []

        for componentType in componentTypes {
          if self.has(componentType) {
            components.append(self[componentType]!)
          }
        }

        return components
      }
      return .init(reflecting: componentsInEntity)
    }
  }

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
#endif

#if os(iOS)
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
  //  extension RealityKit.AccessibilityComponent: CustomDumpReflectable {
  //    public var customDumpMirror: Mirror {
  //      .init(
  //        self,
  //        children: [
  //          //TODO
  //        ]
  //      )
  //    }
  //  }

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

#if os(iOS)
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

#if os(iOS)
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

#if os(iOS)
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
