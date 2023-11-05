// This file was automatically generated and should not be edited.

import Foundation
import Models
import RealityKit
extension RealityPlatform.visionOS {
    public enum Component: Codable, Hashable {
        case accessibilityComponent(AccessibilityComponent)
        case adaptiveResolutionComponent(AdaptiveResolutionComponent)
        case ambientAudioComponent(AmbientAudioComponent)
        case anchoringComponent(AnchoringComponent)
        case audioMixGroupsComponent(AudioMixGroupsComponent)
        case channelAudioComponent(ChannelAudioComponent)
        case characterControllerComponent(CharacterControllerComponent)
        case characterControllerStateComponent(CharacterControllerStateComponent)
        case collisionComponent(CollisionComponent)
        case groundingShadowComponent(GroundingShadowComponent)
        case hoverEffectComponent(HoverEffectComponent)
        case imageBasedLightComponent(ImageBasedLightComponent)
        case imageBasedLightReceiverComponent(ImageBasedLightReceiverComponent)
        case inputTargetComponent(InputTargetComponent)
        case modelComponent(ModelComponent)
        case modelDebugOptionsComponent(ModelDebugOptionsComponent)
        case modelSortGroupComponent(ModelSortGroupComponent)
        case opacityComponent(OpacityComponent)
        case particleEmitterComponent(ParticleEmitterComponent)
        case perspectiveCameraComponent(PerspectiveCameraComponent)
        case physicsBodyComponent(PhysicsBodyComponent)
        case physicsMotionComponent(PhysicsMotionComponent)
        case physicsSimulationComponent(PhysicsSimulationComponent)
        case portalComponent(PortalComponent)
        case sceneUnderstandingComponent(SceneUnderstandingComponent)
        case spatialAudioComponent(SpatialAudioComponent)
        case synchronizationComponent(SynchronizationComponent)
        case textComponent(TextComponent)
        case transform(Transform)
        case videoPlayerComponent(VideoPlayerComponent)
        case worldComponent(WorldComponent)
    }
}
extension RealityPlatform.visionOS.Component: CustomStringConvertible {
    public var description: String {
        switch self {
        case .accessibilityComponent:
          return "AccessibilityComponent"
        case .adaptiveResolutionComponent:
          return "AdaptiveResolutionComponent"
        case .ambientAudioComponent:
          return "AmbientAudioComponent"
        case .anchoringComponent:
          return "AnchoringComponent"
        case .audioMixGroupsComponent:
          return "AudioMixGroupsComponent"
        case .channelAudioComponent:
          return "ChannelAudioComponent"
        case .characterControllerComponent:
          return "CharacterControllerComponent"
        case .characterControllerStateComponent:
          return "CharacterControllerStateComponent"
        case .collisionComponent:
          return "CollisionComponent"
        case .groundingShadowComponent:
          return "GroundingShadowComponent"
        case .hoverEffectComponent:
          return "HoverEffectComponent"
        case .imageBasedLightComponent:
          return "ImageBasedLightComponent"
        case .imageBasedLightReceiverComponent:
          return "ImageBasedLightReceiverComponent"
        case .inputTargetComponent:
          return "InputTargetComponent"
        case .modelComponent:
          return "ModelComponent"
        case .modelDebugOptionsComponent:
          return "ModelDebugOptionsComponent"
        case .modelSortGroupComponent:
          return "ModelSortGroupComponent"
        case .opacityComponent:
          return "OpacityComponent"
        case .particleEmitterComponent:
          return "ParticleEmitterComponent"
        case .perspectiveCameraComponent:
          return "PerspectiveCameraComponent"
        case .physicsBodyComponent:
          return "PhysicsBodyComponent"
        case .physicsMotionComponent:
          return "PhysicsMotionComponent"
        case .physicsSimulationComponent:
          return "PhysicsSimulationComponent"
        case .portalComponent:
          return "PortalComponent"
        case .sceneUnderstandingComponent:
          return "SceneUnderstandingComponent"
        case .spatialAudioComponent:
          return "SpatialAudioComponent"
        case .synchronizationComponent:
          return "SynchronizationComponent"
        case .textComponent:
          return "TextComponent"
        case .transform:
          return "Transform"
        case .videoPlayerComponent:
          return "VideoPlayerComponent"
        case .worldComponent:
          return "WorldComponent"
        }
    }
}
extension RealityPlatform.visionOS.Component {
    public var comment: String? {
        switch self {
        case .accessibilityComponent(let value):
          return value.comment
        case .adaptiveResolutionComponent(let value):
          return value.comment
        case .ambientAudioComponent(let value):
          return value.comment
        case .anchoringComponent(let value):
          return value.comment
        case .audioMixGroupsComponent(let value):
          return value.comment
        case .channelAudioComponent(let value):
          return value.comment
        case .characterControllerComponent(let value):
          return value.comment
        case .characterControllerStateComponent(let value):
          return value.comment
        case .collisionComponent(let value):
          return value.comment
        case .groundingShadowComponent(let value):
          return value.comment
        case .hoverEffectComponent(let value):
          return value.comment
        case .imageBasedLightComponent(let value):
          return value.comment
        case .imageBasedLightReceiverComponent(let value):
          return value.comment
        case .inputTargetComponent(let value):
          return value.comment
        case .modelComponent(let value):
          return value.comment
        case .modelDebugOptionsComponent(let value):
          return value.comment
        case .modelSortGroupComponent(let value):
          return value.comment
        case .opacityComponent(let value):
          return value.comment
        case .particleEmitterComponent(let value):
          return value.comment
        case .perspectiveCameraComponent(let value):
          return value.comment
        case .physicsBodyComponent(let value):
          return value.comment
        case .physicsMotionComponent(let value):
          return value.comment
        case .physicsSimulationComponent(let value):
          return value.comment
        case .portalComponent(let value):
          return value.comment
        case .sceneUnderstandingComponent(let value):
          return value.comment
        case .spatialAudioComponent(let value):
          return value.comment
        case .synchronizationComponent(let value):
          return value.comment
        case .textComponent(let value):
          return value.comment
        case .transform(let value):
          return value.comment
        case .videoPlayerComponent(let value):
          return value.comment
        case .worldComponent(let value):
          return value.comment
        }
    }
}
//MARK: visionOS

extension RealityPlatform.visionOS {
    public struct AccessibilityComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.AccessibilityComponent) {
            //TODO: self.value = component.value
            //TODO: self.isAccessibilityElement = component.isAccessibilityElement
            //TODO: self.label = component.label
            //TODO: self.customActions = component.customActions
            //TODO: self.customContent = component.customContent
            //TODO: self.systemActions = component.systemActions
        }
        #endif
}
    public struct AdaptiveResolutionComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.AdaptiveResolutionComponent) {
            //TODO: self.pixelsPerMeter = component.pixelsPerMeter
            self.comment =
  """
  Allows an entity to change the resolution of the resources it uses according to its relevance to the user.
  """
        }
        #endif
}
    public struct AmbientAudioComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.AmbientAudioComponent) {
            //TODO: self.gain = component.gain
            //TODO: self.hashValue = component.hashValue
            self.comment =
  """
  Configure ambient rendering of sounds from an entity.  Ambient audio sources emit each channel of an audio resource from an angle projected from the entity, without reverberation. Ambient audio sources take into account the relative orientation of the source and the listener. Position is not taken into account; the channels do not get louder as the user moves toward them.  The audio resource's front channels (e.g., mono, center) are projected into the entity's -Z direction, with the rear channels projected into +Z. The left channels are laid out in -X and the right channels are laid out in +X.  ```swift let entity = Entity() let resource = try AudioFileResource.load(named: "MyAudioFile") entity.ambientAudio = AmbientAudioComponent() entity.playAudio(resource) ```  The `AmbientAudioComponent` allows you to set the overall level of all sounds played from the entity with the `gain` property, in relative Decibels, in the range `-.infinity ... .zero` where `-infinity` is silent and `.zero` is nominal.  ```swift entity.ambientAudio?.gain = -10 ```  Ambient audio sources are well suited to play back multichannel content which captures the acoustics of its originating environment in the recording process (e.g., multichannel field recordings of outdoor environments).
  """
        }
        #endif
}
    public struct AnchoringComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.AnchoringComponent) {
            //TODO: self.target = component.target
            //TODO: self.trackingMode = component.trackingMode
            self.comment =
  """
  A description of how virtual content can be anchored to the real world.
  """
        }
        #endif
}
    public struct AudioMixGroupsComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.AudioMixGroupsComponent) {
            //TODO: self.hashValue = component.hashValue
        }
        #endif
}
    public struct ChannelAudioComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.ChannelAudioComponent) {
            //TODO: self.hashValue = component.hashValue
            //TODO: self.gain = component.gain
            self.comment =
  """
  Configure channel-based rendering of sounds from an entity.  Channel audio sources route the audio resource's channels directly to the device's output without any spatialization or reverberation applied. Neither the position nor orientation of the entity is taken into consideration for channel rendering. For example, the left channel will always be heard from the left, and the right channel will always be heard from the right, regardless of where the user is oriented.  The channels of multichannel audio resources are panned according to their channel layout, including rear channels.  ```swift let entity = Entity() let resource = try AudioFileResource.load(named: "MyAudioFile") entity.channelAudio = ChannelAudioComponent() entity.playAudio(resource) ```  The `ChannelAudioComponent` allows you to set the overall level of all sounds played from the entity with the `gain` property, in relative Decibels, in the range `-.infinity ... .zero` where `-infinity` is silent and `.zero` is nominal.  ```swift entity.channelAudio?.gain = -10 ```  Channel audio sources are well suited to play back sounds not associated with any visual elements in a scene.
  """
        }
        #endif
}
    public struct CharacterControllerComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.CharacterControllerComponent) {
            //TODO: self.stepLimit = component.stepLimit
            //TODO: self.height = component.height
            //TODO: self.collisionFilter = component.collisionFilter
            //TODO: self.slopeLimit = component.slopeLimit
            //TODO: self.radius = component.radius
            //TODO: self.upVector = component.upVector
            //TODO: self.skinWidth = component.skinWidth
            self.comment =
  """
  A component that manages character movement.  To use a character controller, add a ``CharacterControllerComponent`` and a ``CharacterControllerStateComponent`` to your entity to make it a character entity. Character entities can *move* to new locations in space, which happens over a period of time based on how you've configured the character controller component, and also *teleport*, which moves the charcter to the new location instantaneously.  - Note: PhysicsBodyComponent and CollisionComponent can not exist on the same Entity that contains         a CharacterControllerComponent and are therefore inactivated.
  """
        }
        #endif
}
    public struct CharacterControllerStateComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.CharacterControllerStateComponent) {
            //TODO: self.isOnGround = component.isOnGround
            //TODO: self.velocity = component.velocity
            self.comment =
  """
  An object that maintains state for a character controller.  Add this component to an entity, this along with ``CharacterControllerComponent``, to use the entity as a character that moves and animates.
  """
        }
        #endif
}
    public struct CollisionComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.CollisionComponent) {
            //TODO: self.mode = component.mode
            //TODO: self.shapes = component.shapes
            //TODO: self.collisionOptions = component.collisionOptions
            //TODO: self.isStatic = component.isStatic
            //TODO: self.filter = component.filter
            self.comment =
  """
  A component that gives an entity the ability to collide with other entities that also have collision components.  This component holds the entity's data related to participating in the scene's physics simulation. It is also used to calculate collision queries, raycasts, and convex shape casts. Entities can participate in the scene simulation in two different modes: as a *rigid body* or as a *trigger*.  A rigid body fully participates in the collision simulation. It affects the velocity and direction of entities it collides. If configured with a rigid body ``RealityKit/PhysicsBodyComponent/mode`` of ``RealityKit/PhysicsBodyMode/dynamic``, it's own velocity and direction can be affected by other rigid body entities. A trigger entity doesn't have any impact on the rigid bodies in the scene, but can trigger code or Reality Composer behaviors when a rigid body enity overlaps it.  Note the following when considering applying a non-uniform scale to an entity: - Non-uniform scaling is applicable only to box, convex mesh and triangle mesh collision shapes. - Non-uniform scaling is not supported for all other types of collision shapes. In this case the scale.x value is duplicated to the scale's y and z components as well to force scale uniformity based on the x component. - If the entity has a non-uniform scale assigned to its transform then that entity should not have any descendants assigned that contain rotations in their transforms. A good rule of thumb is to assign the non-uniform scale to the entity that has the collision shape, and avoid adding children below that entity.  Turn an entity into a trigger by adding a ``RealityKit/CollisionComponent`` to it and setting its ``RealityKit/CollisionComponent/mode-swift.property`` to ``RealityKit/CollisionComponent/Mode-swift.enum/trigger``.  Turn an entity into a _rigd body_ by adding a  ``RealityKit/PhysicsBodyComponent`` to the entity in addition to a ``RealityKit/CollisionComponent``.  The ``PhysicsBodyComponent`` defines the physical properties of the entity, such as its mass and collision shape.  The `filter` property defines the entity's collision filter, which determines which other objects the entity collides with. For more information, see <doc:controlling-entity-collisions-in-realitykit>.  - Note: If an entity has a ``RealityKit/PhysicsBodyComponent``, the  collision component's mode is ignored. An entity can be a rigid body, or a trigger, but not both at the same time.
  """
        }
        #endif
}
    public struct GroundingShadowComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.GroundingShadowComponent) {
            //TODO: self.castsShadow = component.castsShadow
        }
        #endif
}
    public struct HoverEffectComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.HoverEffectComponent) {
            self.comment =
  """
  A component that applies a standard highlight effect when someone focuses an entity.   - Note: A `CollisionComponent` is required for the ``Entity`` to be part of hit-testing.
  """
        }
        #endif
}
    public struct ImageBasedLightComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.ImageBasedLightComponent) {
            //TODO: self.source = component.source
            //TODO: self.inheritsRotation = component.inheritsRotation
            //TODO: self.intensityExponent = component.intensityExponent
        }
        #endif
}
    public struct ImageBasedLightReceiverComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.ImageBasedLightReceiverComponent) {
            //TODO: self.imageBasedLight = component.imageBasedLight
        }
        #endif
}
    public struct InputTargetComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.InputTargetComponent) {
            //TODO: self.allowedInputTypes = component.allowedInputTypes
            //TODO: self.isEnabled = component.isEnabled
            self.comment =
  """
  A component that gives an entity the ability to receive system input.  This component should be added to an entity to inform the system that it should be treated as a target for input handling. It can be customized to require only specific forms of input like direct or indirect interactions. By default the component is configured to handle all forms of input on the system.  The hit testing shape that defines the entity's interactive entity is defined by the `CollisionComponent`. To configure an entity for input but avoid any sort of physics-related processing, add an `InputTargetComponent` and `CollisionComponent`, but disable the `CollisionComponent` for collision detection, for example:  ``` // Enable the entity for input. myEntity.components.set(InputTargetComponent())  // Create a collision component with an empty group and mask. var collision = CollisionComponent(shapes: [.generateSphere(radius: 0.1)]) collision.filter = CollisionFilter(group: [], mask: []) myEntity.components.set(collision) ```  `InputTargetComponent` behaves hierarchically, so if it is added to an entity that has descendants with `CollisionComponent`s, those shapes will be used for input handling. The `isEnabled` flag can be used to override this behavior by adding the `InputTargetComponent` to a descendant and setting `isEnabled` to false.  `InputTargetComponent`'s `allowedInputTypes` property allows the entity to only receive the provided types of input. This property also propagates down the hierarchy, but if a descendant also has an `InputTargetComponent` defined, its `allowedInputTypes` property overrides the value provided by the ancestor.
  """
        }
        #endif
}
    public struct ModelComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.ModelComponent) {
            //TODO: self.mesh = component.mesh
            //TODO: self.materials = component.materials
            //TODO: self.boundsMargin = component.boundsMargin
            self.comment =
  """
  A collection of resources that create the visual appearance of an entity.
  """
        }
        #endif
}
    public struct ModelDebugOptionsComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.ModelDebugOptionsComponent) {
            //TODO: self.visualizationMode = component.visualizationMode
            self.comment =
  """
  A component that changes how RealityKit renders its entity to help with debugging.  Attaching a `ModelDebugOptionsComponent` to a ``ModelEntity`` tells RealityKit to change the way it renders that entity based on a specified ``ModelDebugOptionsComponent/visualizationMode-swift.property``. This component isolates individual parts of the rendering process, such as the entity’s transparency or roughness, and displays surface color to help identify visual anomalies.  To use this component, create a `ModelDebugOptionsComponent` and set its ``ModelDebugOptionsComponent/visualizationMode-swift.property`` to the desired value. Then, set the component as the entity’s ``ModelEntity/modelDebugOptions`` property:  ```swift if let robot = anchor.findEntity(named: "Robot") as? ModelEntity {     let component = ModelDebugOptionsComponent(visualizationMode: .normal)     robot.modelDebugOptions = component } ```  For more information on the visualization modes supported by `ModelDebugOptionsComponent`, see ``ModelDebugOptionsComponent/VisualizationMode-swift.enum``.  ## Attach a Debug Component to an Entity  To attach a debug component to a particular entity, traverse the entity tree while passing the component to each child:  ```swift // Traverse the entity tree to attach a certain debug mode through components. func attachDebug(entity: Entity, debug: ModelDebugOptionsComponent) {     entity.components.set(debug)     for child in entity.children {         attachDebug(entity: child, debug: debug)     } } // Respond to a button or UI element. func debugLightingDiffuseButtonCallback() {     let debugComponent = ModelDebugOptionsComponent(visualizationMode: .lightingDiffuse)     attachDebug(entity: model, debug: debugComponent) } ```  ## Attach a Debug Component to a Trait  To attach a debug component based on a trait, traverse the entity tree while checking for ``HasModel`` adoption:  ```swift func attachDebug(entity: Entity, debug: ModelDebugOptionsComponent) {     if let model = entity as? ModelEntity {         model.visualizationMode = debug     }     for child in entity.children {         attachDebug(entity: child, debug: debug)     } } // Respond to a button or UI element. func debugLightingDiffuseButtonCallback() {     let debugComponent = ModelDebugOptionsComponent(visualizationMode: .lightingDiffuse)     attachDebug(entity: model, debug: debugComponent) } ```
  """
        }
        #endif
}
    public struct ModelSortGroupComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.ModelSortGroupComponent) {
            //TODO: self.order = component.order
            //TODO: self.group = component.group
            self.comment =
  """
  A component that allows an entity's models to be rendered in an explicit order relative to the models of other entities in the same sort group. If this component is on an entity, then it must belong to a sort group.
  """
        }
        #endif
}
    public struct OpacityComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.OpacityComponent) {
            //TODO: self.opacity = component.opacity
        }
        #endif
}
    public struct ParticleEmitterComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.ParticleEmitterComponent) {
            //TODO: self.spawnedEmitter = component.spawnedEmitter
            //TODO: self.spawnSpreadFactor = component.spawnSpreadFactor
            //TODO: self.fieldSimulationSpace = component.fieldSimulationSpace
            //TODO: self.isEmitting = component.isEmitting
            //TODO: self.torusInnerRadius = component.torusInnerRadius
            //TODO: self.speedVariation = component.speedVariation
            //TODO: self.burstCountVariation = component.burstCountVariation
            //TODO: self.emitterShapeSize = component.emitterShapeSize
            //TODO: self.birthDirection = component.birthDirection
            //TODO: self.particlesInheritTransform = component.particlesInheritTransform
            //TODO: self.spawnVelocityFactor = component.spawnVelocityFactor
            //TODO: self.radialAmount = component.radialAmount
            //TODO: self.emitterShape = component.emitterShape
            //TODO: self.mainEmitter = component.mainEmitter
            //TODO: self.spawnSpreadFactorVariation = component.spawnSpreadFactorVariation
            //TODO: self.burstCount = component.burstCount
            //TODO: self.spawnOccasion = component.spawnOccasion
            //TODO: self.birthLocation = component.birthLocation
            //TODO: self.emissionDirection = component.emissionDirection
            //TODO: self.simulationState = component.simulationState
            //TODO: self.speed = component.speed
            //TODO: self.spawnInheritsParentColor = component.spawnInheritsParentColor
        }
        #endif
}
    public struct PerspectiveCameraComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.PerspectiveCameraComponent) {
            //TODO: self.fieldOfViewInDegrees = component.fieldOfViewInDegrees
            //TODO: self.far = component.far
            //TODO: self.near = component.near
            self.comment =
  """
   In AR applications, the camera is automatically provided by the system. In non-AR scenarios, the camera needs to be set by the app. (If no camera is provided by the app, the system will use default camera.)
  """
        }
        #endif
}
    public struct PhysicsBodyComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.PhysicsBodyComponent) {
            //TODO: self.isRotationLocked = component.isRotationLocked
            //TODO: self.isContinuousCollisionDetectionEnabled = component.isContinuousCollisionDetectionEnabled
            //TODO: self.linearDamping = component.linearDamping
            //TODO: self.material = component.material
            //TODO: self.isTranslationLocked = component.isTranslationLocked
            //TODO: self.mode = component.mode
            //TODO: self.isAffectedByGravity = component.isAffectedByGravity
            //TODO: self.massProperties = component.massProperties
            //TODO: self.angularDamping = component.angularDamping
            self.comment =
  """
  A component that defines an entity’s behavior in physics body simulations.  To participate in a scene's physics simulation, an entity must have a ``RealityKit/PhysicsBodyComponent`` and a ``RealityKit/CollisionComponent``. If you need to move an entity that participates in the physics system, it also needs a ``RealityKit/PhysicsMotionComponent``.  Add a physics body component to an entity by adopting the ``HasPhysicsBody`` protocol, which allows RealityKit’s physics simulation to compute behavior in response to forces acting upon the body, following basic rules of Newtonian mechanics.  Note the following when considering applying a non-uniform scale to an entity: - Non-uniform scaling is applicable only to box, convex mesh and triangle mesh collision shapes. - Non-uniform scaling is not supported for all other types of collision shapes. In this case the scale.x value is duplicated to the scale's y and z components as well to force scale uniformity based on the x component. - If the entity has a non-uniform scale assigned to its transform then that entity should not have any descendants assigned that contain rotations in their transforms. A good rule of thumb is to assign the non-uniform scale to the entity that has the collision shape, and avoid adding children below that entity.  - Note: Model entities have a physics body component by default.
  """
        }
        #endif
}
    public struct PhysicsMotionComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.PhysicsMotionComponent) {
            //TODO: self.angularVelocity = component.angularVelocity
            //TODO: self.linearVelocity = component.linearVelocity
            self.comment =
  """
  A component that controls the motion of the body in physics simulations.  You specify velocities in the coordinate space of the physics simulation defined by ``ARView/PhysicsSimulationComponent.nearestSimulationEntity``.  The behavior of an entity with a physics motion component depends on the entity’s ``PhysicsBodyComponent/mode`` setting:  - term ``PhysicsBodyMode/static``: The physics simulation ignores the velocities. The entity doesn’t move. - term ``PhysicsBodyMode/kinematic``: The physics simulation moves the body according to the values you set for ``PhysicsMotionComponent/angularVelocity`` and ``PhysicsMotionComponent/linearVelocity``. - term ``PhysicsBodyMode/dynamic``: The physics simulation overwrites the velocity values based on simulation, and ignores any values that you write.
  """
        }
        #endif
}
    public struct PhysicsSimulationComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.PhysicsSimulationComponent) {
            //TODO: self.gravity = component.gravity
            //TODO: self.collisionOptions = component.collisionOptions
            //TODO: self.clock = component.clock
            self.comment =
  """
  A component that controls localized physics simulations.  To use a localized physics simulation add a ``PhysicsSimulationComponent`` to the desired root entity. Use the component to set custom physics simulation properties such as ``gravity`` and ``collisionOptions`` specific to the physics simulation.
  """
        }
        #endif
}
    public struct PortalComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.PortalComponent) {
            //TODO: self.targetEntity = component.targetEntity
            //TODO: self.clippingPlane = component.clippingPlane
        }
        #endif
}
    public struct SceneUnderstandingComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.SceneUnderstandingComponent) {
            //TODO: self.entityType = component.entityType
            //TODO: self.origin = component.origin
            self.comment =
  """
  A component that maps features of the physical environment.  Example features include faces and the shape of arbitrary regions.
  """
        }
        #endif
}
    public struct SpatialAudioComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.SpatialAudioComponent) {
            //TODO: self.directLevel = component.directLevel
            //TODO: self.directivity = component.directivity
            //TODO: self.reverbLevel = component.reverbLevel
            //TODO: self.gain = component.gain
            //TODO: self.hashValue = component.hashValue
            self.comment =
  """
  Configure how sounds are emitted from an entity into the user's environment.  The position and orientation of spatial audio sources are updated continuously and automatically by the audio system, so sounds always come from an entity wherever it goes and wherever it is pointing. Spatial audio sources have the user environment's acoustics applied to them so that they blend in naturally with it, and they are distance attenuated so they become quieter the further away they are from the user.  - Note: Spatial audio sources emit only a single channel (i.e., mono). If the format of the audio resource played on the entity is stereo or multichannel, all of its channels will be mixed down to a single channel before spatialization. To minimize any unwanted mixdown artifacts, use mono source material where possible.  RealityKit audio playback is spatial by default, so no additional configuration is necessary to opt into sophisticated spatial rendering.  ```swift let entity = Entity() let resource = try AudioFileResource.load(named: "MyAudioFile") entity.playAudio(resource) // Audio file is played spatially from entity ```  The `SpatialAudioComponent` allows you to further customize the playback characteristics of spatial audio sources. The `gain`, `directLevel`, and `reverbLevel` properties are in relative Decibels, in the range `-.infinity ... .zero`, where `-.infinity` is silent and `.zero` is nominal.  For example, you can adjust the overall level of all sounds played from the entity with the `gain` property.  ```swift entity.spatialAudio = SpatialAudioComponent(gain: -10) ```  You can reduce the amount of reverb applied to all sounds played from the entity with the `reverbLevel` property. Reducing this value will make the sounds less reverberant and more intimate. Setting `reverbLevel` to `-.infinity` will cause the sounds to collapse into the head of the listener.  ```swift entity.spatialAudio?.reverbLevel = -6 ```  The `gain`, `directLevel`, and `reverbLevel` properties can be updated dynamically, for example based on your app's state, or in the context of a Custom RealityKit System.  The `directivity` property allows you to configure the radiation pattern for sound emitted from the entity.  ```swift entity.spatialAudio?.directivity = .beam(focus: 0.5) ```  Spatial audio sources project sounds along their -Z axis. If a spatial audio source is co-located and co-oriented with visual content authored with a +Z-forward coordinate convention, you will want to rotate your spatial audio source 180º about the Y-axis.  ```swift let parent = Entity()  // Add model entity let model = try ModelEntity.load(named: "PositiveZForward") parent.addChild(model)  // Add audio source entity let audioSource = Entity() parent.addChild(audioSource)  // Orient audio source towards +Z audioSource.orientation = .init(angle: .pi, axis: [0, 1, 0]) ```  This is only a consideration if you have explicitly set a `directivity` other than the default `.beam(focus: .zero)`, which projects sound evenly for all frequencies in all directions.
  """
        }
        #endif
}
    public struct SynchronizationComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.SynchronizationComponent) {
            //TODO: self.ownershipTransferMode = component.ownershipTransferMode
            //TODO: self.isOwner = component.isOwner
            //TODO: self.identifier = component.identifier
            self.comment =
  """
  A component that synchronizes an entity between processes and networked applications.  An entity acquires a ``SynchronizationComponent`` instance by adopting the ``HasSynchronization`` protocol. All entities have this component because the ``Entity`` base class adopts the protocol.
  """
        }
        #endif
}
    public struct TextComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.TextComponent) {
            //TODO: self.size = component.size
            //TODO: self.cornerRadius = component.cornerRadius
            //TODO: self.text = component.text
            //TODO: self.backgroundColor = component.backgroundColor
        }
        #endif
}
    public struct Transform: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.Transform) {
            //TODO: self.hashValue = component.hashValue
            //TODO: self.translation = component.translation
            //TODO: self.scale = component.scale
            //TODO: self.matrix = component.matrix
            //TODO: self.rotation = component.rotation
            self.comment =
  """
  A component that defines the scale, rotation, and translation of an entity.  An entity acquires a ``Transform`` component, as well as a set of methods for manipulating the transform, by adopting the ``HasTransform`` protocol. This is true for all entities, because the ``Entity`` base class adopts the protocol.
  """
        }
        #endif
}
    public struct VideoPlayerComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.VideoPlayerComponent) {
            //TODO: self.screenVideoDimension = component.screenVideoDimension
            //TODO: self.avPlayer = component.avPlayer
            //TODO: self.currentScreenVideoDimension = component.currentScreenVideoDimension
            //TODO: self.isPassthroughTintingEnabled = component.isPassthroughTintingEnabled
            //TODO: self.playerScreenSize = component.playerScreenSize
            //TODO: self.desiredViewingMode = component.desiredViewingMode
            //TODO: self.viewingMode = component.viewingMode
        }
        #endif
}
    public struct WorldComponent: Codable, Hashable {
        public var comment: String?
        #if os(visionOS)
        init(rawValue component: RealityKit.WorldComponent) {
            self.comment =
  """
  When set on an entity, a WorldComponent separates the entity and its subtree to be rendered as part of a diferent world, that is only visible through a portal.  Entities in a WorldComponent are rendered in a isolated lighting environment. To light entities in this environment, use an ImageBasedLightComponent placed within the entity subtree.
  """
        }
        #endif
}
}
#if os(visionOS)
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
