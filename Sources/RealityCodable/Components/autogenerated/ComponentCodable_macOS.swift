// This file was automatically generated and should not be edited.

import CustomDump
import Foundation
import Models
import RealityKit
extension RealityPlatform.macOS {
    public enum Component: Codable, Hashable {
        case accessibilityComponent(AccessibilityComponent)
        case anchoringComponent(AnchoringComponent)
        case characterControllerComponent(CharacterControllerComponent)
        case characterControllerStateComponent(CharacterControllerStateComponent)
        case collisionComponent(CollisionComponent)
        case directionalLightComponent(DirectionalLightComponent)
        case modelComponent(ModelComponent)
        case modelDebugOptionsComponent(ModelDebugOptionsComponent)
        case perspectiveCameraComponent(PerspectiveCameraComponent)
        case physicsBodyComponent(PhysicsBodyComponent)
        case physicsMotionComponent(PhysicsMotionComponent)
        case pointLightComponent(PointLightComponent)
        case spotLightComponent(SpotLightComponent)
        case synchronizationComponent(SynchronizationComponent)
        case transform(Transform)
    }
}
extension RealityPlatform.macOS.Component: CustomStringConvertible {
    public var description: String {
        switch self {
        case .accessibilityComponent:
          return "AccessibilityComponent"
        case .anchoringComponent:
          return "AnchoringComponent"
        case .characterControllerComponent:
          return "CharacterControllerComponent"
        case .characterControllerStateComponent:
          return "CharacterControllerStateComponent"
        case .collisionComponent:
          return "CollisionComponent"
        case .directionalLightComponent:
          return "DirectionalLightComponent"
        case .modelComponent:
          return "ModelComponent"
        case .modelDebugOptionsComponent:
          return "ModelDebugOptionsComponent"
        case .perspectiveCameraComponent:
          return "PerspectiveCameraComponent"
        case .physicsBodyComponent:
          return "PhysicsBodyComponent"
        case .physicsMotionComponent:
          return "PhysicsMotionComponent"
        case .pointLightComponent:
          return "PointLightComponent"
        case .spotLightComponent:
          return "SpotLightComponent"
        case .synchronizationComponent:
          return "SynchronizationComponent"
        case .transform:
          return "Transform"
        }
    }
}
extension RealityPlatform.macOS.Component {
    public var comment: String? {
        switch self {
        case .accessibilityComponent(let value):
          return value.comment
        case .anchoringComponent(let value):
          return value.comment
        case .characterControllerComponent(let value):
          return value.comment
        case .characterControllerStateComponent(let value):
          return value.comment
        case .collisionComponent(let value):
          return value.comment
        case .directionalLightComponent(let value):
          return value.comment
        case .modelComponent(let value):
          return value.comment
        case .modelDebugOptionsComponent(let value):
          return value.comment
        case .perspectiveCameraComponent(let value):
          return value.comment
        case .physicsBodyComponent(let value):
          return value.comment
        case .physicsMotionComponent(let value):
          return value.comment
        case .pointLightComponent(let value):
          return value.comment
        case .spotLightComponent(let value):
          return value.comment
        case .synchronizationComponent(let value):
          return value.comment
        case .transform(let value):
          return value.comment
        }
    }
}
extension RealityPlatform.macOS.Component {
    public var reflectedDescription: String? {
        switch self {
        case .accessibilityComponent(let value):
          return value.reflectedDescription
        case .anchoringComponent(let value):
          return value.reflectedDescription
        case .characterControllerComponent(let value):
          return value.reflectedDescription
        case .characterControllerStateComponent(let value):
          return value.reflectedDescription
        case .collisionComponent(let value):
          return value.reflectedDescription
        case .directionalLightComponent(let value):
          return value.reflectedDescription
        case .modelComponent(let value):
          return value.reflectedDescription
        case .modelDebugOptionsComponent(let value):
          return value.reflectedDescription
        case .perspectiveCameraComponent(let value):
          return value.reflectedDescription
        case .physicsBodyComponent(let value):
          return value.reflectedDescription
        case .physicsMotionComponent(let value):
          return value.reflectedDescription
        case .pointLightComponent(let value):
          return value.reflectedDescription
        case .spotLightComponent(let value):
          return value.reflectedDescription
        case .synchronizationComponent(let value):
          return value.reflectedDescription
        case .transform(let value):
          return value.reflectedDescription
        }
    }
}
//MARK: macOS

extension RealityPlatform.macOS {
    public struct AccessibilityComponent: Codable, Hashable {
        public var comment: String?
        public var reflectedDescription: String
        #if os(macOS)
      @available(macOS 14.0, *)
      init(rawValue component: RealityKit.AccessibilityComponent) {
            //TODO: self.label = component.label
            //TODO: self.customActions = component.customActions
            //TODO: self.isAccessibilityElement = component.isAccessibilityElement
            //TODO: self.value = component.value
            //TODO: self.customContent = component.customContent
            //TODO: self.systemActions = component.systemActions
            self.reflectedDescription = String(customDumping: component)
        }
        #endif
}
    public struct AnchoringComponent: Codable, Hashable {
        public var comment: String?
        public var reflectedDescription: String
        #if os(macOS)
        init(rawValue component: RealityKit.AnchoringComponent) {
            //TODO: self.target = component.target
            self.comment =
  """
  A description of how virtual content can be anchored to the real world.
  """
            self.reflectedDescription = String(customDumping: component)
        }
        #endif
}
    public struct CharacterControllerComponent: Codable, Hashable {
        public var comment: String?
        public var reflectedDescription: String
        #if os(macOS)
        init(rawValue component: RealityKit.CharacterControllerComponent) {
            //TODO: self.height = component.height
            //TODO: self.collisionFilter = component.collisionFilter
            //TODO: self.radius = component.radius
            //TODO: self.upVector = component.upVector
            //TODO: self.stepLimit = component.stepLimit
            //TODO: self.slopeLimit = component.slopeLimit
            //TODO: self.skinWidth = component.skinWidth
            self.comment =
  """
  A component that manages character movement.  To use a character controller, add a ``CharacterControllerComponent`` and a ``CharacterControllerStateComponent`` to your entity to make it a character entity. Character entities can *move* to new locations in space, which happens over a period of time based on how you've configured the character controller component, and also *teleport*, which moves the charcter to the new location instantaneously.
  """
            self.reflectedDescription = String(customDumping: component)
        }
        #endif
}
    public struct CharacterControllerStateComponent: Codable, Hashable {
        public var comment: String?
        public var reflectedDescription: String
        #if os(macOS)
        init(rawValue component: RealityKit.CharacterControllerStateComponent) {
            //TODO: self.isOnGround = component.isOnGround
            //TODO: self.velocity = component.velocity
            self.comment =
  """
  An object that maintains state for a character controller.  Add this component to an entity, this along with ``CharacterControllerComponent``, to use the entity as a character that moves and animates.
  """
            self.reflectedDescription = String(customDumping: component)
        }
        #endif
}
    public struct CollisionComponent: Codable, Hashable {
        public var comment: String?
        public var reflectedDescription: String
        #if os(macOS)
        init(rawValue component: RealityKit.CollisionComponent) {
            //TODO: self.filter = component.filter
            //TODO: self.mode = component.mode
            //TODO: self.shapes = component.shapes
            self.comment =
  """
  A component that gives an entity the ability to collide with other entities that also have collision components.  This component holds the entity's data related to participating in the scene's physics simulation. It is also used to calculate collision queries, raycasts, and convex shape casts. Entities can participate in the scene simulation in two different modes: as a *rigid body* or as a *trigger*.  A rigid body fully participates in the collision simulation. It affects the velocity and direction of entities it collides. If configured with a rigid body ``RealityKit/PhysicsBodyComponent/mode`` of ``RealityKit/PhysicsBodyMode/dynamic``, it's own velocity and direction can be affected by other rigid body entities. A trigger entity doesn't have any impact on the rigid bodies in the scene, but can trigger code or Reality Composer behaviors when a rigid body enity overlaps it.  Turn an entity into a trigger by adding a ``RealityKit/CollisionComponent`` to it and setting its ``RealityKit/CollisionComponent/mode-swift.property`` to ``RealityKit/CollisionComponent/Mode-swift.enum/trigger``.  Turn an entity into a _rigd body_ by adding a  ``RealityKit/PhysicsBodyComponent`` to the entity in addition to a ``RealityKit/CollisionComponent``.  The ``PhysicsBodyComponent`` defines the physical properties of the entity, such as its mass and collision shape.  The `filter` property defines the entity's collision filter, which determines which other objects the entity collides with. For more information, see <doc:controlling-entity-collisions-in-realitykit>.  - Note: If an entity has a ``RealityKit/PhysicsBodyComponent``, the  collision component's mode is ignored. An entity can be a rigid body, or a trigger, but not both at the same time.
  """
            self.reflectedDescription = String(customDumping: component)
        }
        #endif
}
    public struct DirectionalLightComponent: Codable, Hashable {
        public var comment: String?
        public var reflectedDescription: String
        #if os(macOS)
        init(rawValue component: RealityKit.DirectionalLightComponent) {
            //TODO: self.intensity = component.intensity
            //TODO: self.isRealWorldProxy = component.isRealWorldProxy
            self.comment =
  """
  A component that defines a directional light source.  A directional light shines in the entithy's forward direction (0, 0, -1). To orient a directional light, use `HasTransform.look(at:from:upVector:)`.  A directional light source can cast shadows. To enable shadows, create a ``RealityKit/DirectionalLightComponent/Shadow`` and assign it to `HasDirectionalLight.shadow`. To disable shadows set `HasDirectionalLight.shadow` to `nil`.
  """
            self.reflectedDescription = String(customDumping: component)
        }
        #endif
}
    public struct ModelComponent: Codable, Hashable {
        public var comment: String?
        public var reflectedDescription: String
        #if os(macOS)
        init(rawValue component: RealityKit.ModelComponent) {
            //TODO: self.mesh = component.mesh
            //TODO: self.materials = component.materials
            //TODO: self.boundsMargin = component.boundsMargin
            self.comment =
  """
  A collection of resources that create the visual appearance of an entity.
  """
            self.reflectedDescription = String(customDumping: component)
        }
        #endif
}
    public struct ModelDebugOptionsComponent: Codable, Hashable {
        public var comment: String?
        public var reflectedDescription: String
        #if os(macOS)
        init(rawValue component: RealityKit.ModelDebugOptionsComponent) {
            //TODO: self.visualizationMode = component.visualizationMode
            self.comment =
  """
  A component that changes how RealityKit renders its entity to help with debugging.  Attaching a `ModelDebugOptionsComponent` to a ``ModelEntity`` tells RealityKit to change the way it renders that entity based on a specified ``ModelDebugOptionsComponent/visualizationMode-swift.property``. This component isolates individual parts of the rendering process, such as the entity’s transparency or roughness, and displays surface color to help identify visual anomalies.  To use this component, create a `ModelDebugOptionsComponent` and set its ``ModelDebugOptionsComponent/visualizationMode-swift.property`` to the desired value. Then, set the component as the entity’s ``ModelEntity/modelDebugOptions`` property:  ```swift if let robot = anchor.findEntity(named: "Robot") as? ModelEntity {     let component = ModelDebugOptionsComponent(visualizationMode: .normal)     robot.modelDebugOptions = component } ```  For more information on the visualization modes supported by `ModelDebugOptionsComponent`, see ``ModelDebugOptionsComponent/VisualizationMode-swift.enum``.  ## Attach a Debug Component to an Entity  To attach a debug component to a particular entity, traverse the entity tree while passing the component to each child:  ```swift // Traverse the entity tree to attach a certain debug mode through components. func attachDebug(entity: Entity, debug: ModelDebugOptionsComponent) {     entity.components.set(debug)     for child in entity.children {         attachDebug(entity: child, debug: debug)     } } // Respond to a button or UI element. func debugLightingDiffuseButtonCallback() {     let debugComponent = ModelDebugOptionsComponent(visualizationMode: .lightingDiffuse)     attachDebug(entity: model, debug: debugComponent) } ```  ## Attach a Debug Component to a Trait  To attach a debug component based on a trait, traverse the entity tree while checking for ``HasModel`` adoption:  ```swift func attachDebug(entity: Entity, debug: ModelDebugOptionsComponent) {     if let model = entity as? ModelEntity {         model.visualizationMode = debug     }     for child in entity.children {         attachDebug(entity: child, debug: debug)     } } // Respond to a button or UI element. func debugLightingDiffuseButtonCallback() {     let debugComponent = ModelDebugOptionsComponent(visualizationMode: .lightingDiffuse)     attachDebug(entity: model, debug: debugComponent) } ```
  """
            self.reflectedDescription = String(customDumping: component)
        }
        #endif
}
    public struct PerspectiveCameraComponent: Codable, Hashable {
        public var comment: String?
        public var reflectedDescription: String
        #if os(macOS)
        init(rawValue component: RealityKit.PerspectiveCameraComponent) {
            //TODO: self.near = component.near
            //TODO: self.far = component.far
            //TODO: self.fieldOfViewInDegrees = component.fieldOfViewInDegrees
            self.comment =
  """
   In AR applications, the camera is automatically provided by the system. In non-AR scenarios, the camera needs to be set by the app. (If no camera is provided by the app, the system will use default camera.)
  """
            self.reflectedDescription = String(customDumping: component)
        }
        #endif
}
    public struct PhysicsBodyComponent: Codable, Hashable {
        public var comment: String?
        public var reflectedDescription: String
        #if os(macOS)
        init(rawValue component: RealityKit.PhysicsBodyComponent) {
            //TODO: self.isContinuousCollisionDetectionEnabled = component.isContinuousCollisionDetectionEnabled
            //TODO: self.mode = component.mode
            //TODO: self.massProperties = component.massProperties
            //TODO: self.isTranslationLocked = component.isTranslationLocked
            //TODO: self.isRotationLocked = component.isRotationLocked
            //TODO: self.material = component.material
            self.comment =
  """
  A component that defines an entity’s behavior in physics body simulations.  To participate in a scene's physics simulation, an entity must have a ``RealityKit/PhysicsBodyComponent`` and a ``RealityKit/CollisionComponent``. If you need to move an entity that participates in the physics system, it also needs a ``RealityKit/PhysicsMotionComponent``.  Add a physics body component to an entity by adopting the ``HasPhysicsBody`` protocol, which allows RealityKit’s physics simulation to compute behavior in response to forces acting upon the body, following basic rules of Newtonian mechanics.  - Note: Model entities have a physics body component by default.
  """
            self.reflectedDescription = String(customDumping: component)
        }
        #endif
}
    public struct PhysicsMotionComponent: Codable, Hashable {
        public var comment: String?
        public var reflectedDescription: String
        #if os(macOS)
        init(rawValue component: RealityKit.PhysicsMotionComponent) {
            //TODO: self.linearVelocity = component.linearVelocity
            //TODO: self.angularVelocity = component.angularVelocity
            self.comment =
  """
  A component that controls the motion of the body in physics simulations.  You specify velocities in the coordinate space of the physics simulation defined by ``ARView/physicsOrigin``.  The behavior of an entity with a physics motion component depends on the entity’s ``PhysicsBodyComponent/mode`` setting:  - term ``PhysicsBodyMode/static``: The physics simulation ignores the velocities. The entity doesn’t move. - term ``PhysicsBodyMode/kinematic``: The physics simulation moves the body according to the values you set for ``PhysicsMotionComponent/angularVelocity`` and ``PhysicsMotionComponent/linearVelocity``. - term ``PhysicsBodyMode/dynamic``: The physics simulation overwrites the velocity values based on simulation, and ignores any values that you write.
  """
            self.reflectedDescription = String(customDumping: component)
        }
        #endif
}
    public struct PointLightComponent: Codable, Hashable {
        public var comment: String?
        public var reflectedDescription: String
        #if os(macOS)
        init(rawValue component: RealityKit.PointLightComponent) {
            //TODO: self.intensity = component.intensity
            //TODO: self.attenuationRadius = component.attenuationRadius
            self.comment =
  """
  A component that defines a point light source.
  """
            self.reflectedDescription = String(customDumping: component)
        }
        #endif
}
    public struct SpotLightComponent: Codable, Hashable {
        public var comment: String?
        public var reflectedDescription: String
        #if os(macOS)
        init(rawValue component: RealityKit.SpotLightComponent) {
            //TODO: self.outerAngleInDegrees = component.outerAngleInDegrees
            //TODO: self.intensity = component.intensity
            //TODO: self.attenuationRadius = component.attenuationRadius
            //TODO: self.innerAngleInDegrees = component.innerAngleInDegrees
            self.comment =
  """
  A component that defines a spotlight source.  A spot light illuminates a cone-shaped volume in the entity's forward direction (0, 0, -1) . To orient a spot light, use `HasTransform.look(at:from:upVector:)`.  To enable shadows, create a ``RealityKit/DirectionalLightComponent/Shadow`` and assign it to `HasDirectionalLight.shadow`. To disable shadows set `HasDirectionalLight.shadow` to `nil`.
  """
            self.reflectedDescription = String(customDumping: component)
        }
        #endif
}
    public struct SynchronizationComponent: Codable, Hashable {
        public var comment: String?
        public var reflectedDescription: String
        #if os(macOS)
        init(rawValue component: RealityKit.SynchronizationComponent) {
            //TODO: self.ownershipTransferMode = component.ownershipTransferMode
            //TODO: self.identifier = component.identifier
            //TODO: self.isOwner = component.isOwner
            self.comment =
  """
  A component that synchronizes an entity between processes and networked applications.  An entity acquires a ``SynchronizationComponent`` instance by adopting the ``HasSynchronization`` protocol. All entities have this component because the ``Entity`` base class adopts the protocol.
  """
            self.reflectedDescription = String(customDumping: component)
        }
        #endif
}
    public struct Transform: Codable, Hashable {
        public var comment: String?
        public var reflectedDescription: String
        #if os(macOS)
        init(rawValue component: RealityKit.Transform) {
            //TODO: self.matrix = component.matrix
            //TODO: self.translation = component.translation
            //TODO: self.scale = component.scale
            //TODO: self.hashValue = component.hashValue
            //TODO: self.rotation = component.rotation
            self.comment =
  """
  A component that defines the scale, rotation, and translation of an entity.  An entity acquires a ``Transform`` component, as well as a set of methods for manipulating the transform, by adopting the ``HasTransform`` protocol. This is true for all entities, because the ``Entity`` base class adopts the protocol.
  """
            self.reflectedDescription = String(customDumping: component)
        }
        #endif
}
}
#if os(macOS)
extension RealityPlatform.macOS.ComponentType {
    func makeCodable(from component: RealityKit.Component) -> RealityPlatform.macOS.Component {
        switch self {
        case .accessibilityComponent:
          if #available(macOS 14.0, *) {
            return .accessibilityComponent(.init(rawValue: component as! AccessibilityComponent))
          } else {
            fatalError()
          }
        case .anchoringComponent:
          return .anchoringComponent(.init(rawValue: component as! AnchoringComponent))
        case .characterControllerComponent:
          return .characterControllerComponent(.init(rawValue: component as! CharacterControllerComponent))
        case .characterControllerStateComponent:
          return .characterControllerStateComponent(.init(rawValue: component as! CharacterControllerStateComponent))
        case .collisionComponent:
          return .collisionComponent(.init(rawValue: component as! CollisionComponent))
        case .directionalLightComponent:
          return .directionalLightComponent(.init(rawValue: component as! DirectionalLightComponent))
        case .modelComponent:
          return .modelComponent(.init(rawValue: component as! ModelComponent))
        case .modelDebugOptionsComponent:
          return .modelDebugOptionsComponent(.init(rawValue: component as! ModelDebugOptionsComponent))
        case .perspectiveCameraComponent:
          return .perspectiveCameraComponent(.init(rawValue: component as! PerspectiveCameraComponent))
        case .physicsBodyComponent:
          return .physicsBodyComponent(.init(rawValue: component as! PhysicsBodyComponent))
        case .physicsMotionComponent:
          return .physicsMotionComponent(.init(rawValue: component as! PhysicsMotionComponent))
        case .pointLightComponent:
          return .pointLightComponent(.init(rawValue: component as! PointLightComponent))
        case .spotLightComponent:
          return .spotLightComponent(.init(rawValue: component as! SpotLightComponent))
        case .synchronizationComponent:
          return .synchronizationComponent(.init(rawValue: component as! SynchronizationComponent))
        case .transform:
          return .transform(.init(rawValue: component as! Transform))
        }
    }
}
#endif
