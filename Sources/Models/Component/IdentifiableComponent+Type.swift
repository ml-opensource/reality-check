import RealityKit

extension IdentifiableComponent.ComponentType: RawRepresentable {
  public var rawValue: Component.Type {
    switch self {
      case .anchoring:
        return AnchoringComponent.self

      case .characterController:
        return CharacterControllerComponent.self

      case .characterControllerState:
        return CharacterControllerStateComponent.self

      case .collision:
        return CollisionComponent.self

      case .directionalLight:
        #if !os(xrOS)
          return DirectionalLightComponent.self
        #else
          //FIXME: xrOS compatibility
          return AnchoringComponent.self
        #endif

      case .directionalLightShadow:
        #if !os(xrOS)
          return DirectionalLightComponent.Shadow.self
        #else
          //FIXME: xrOS compatibility
          return AnchoringComponent.self
        #endif

      case .model:
        return ModelComponent.self

      case .modelDebugOptions:
        return ModelDebugOptionsComponent.self

      case .perspectiveCamera:
        return PerspectiveCameraComponent.self

      case .physicsBody:
        return PhysicsBodyComponent.self

      case .physicsMotion:
        return PhysicsMotionComponent.self

      case .pointLight:
        #if !os(xrOS)
          return PointLightComponent.self
        #else
          //FIXME: xrOS compatibility
          return AnchoringComponent.self
        #endif

      case .spotLight:
        #if !os(xrOS)
          return SpotLightComponent.self
        #else
          //FIXME: xrOS compatibility
          return AnchoringComponent.self
        #endif

      case .spotLightShadow:
        #if !os(xrOS)
          return SpotLightComponent.Shadow.self
        #else
          //FIXME: xrOS compatibility
          return AnchoringComponent.self
        #endif

      case .synchronization:
        return SynchronizationComponent.self

      case .transform:
        return Transform.self
    }
  }

  public init?(
    rawValue: Component.Type
  ) {
    for componentType in Self.allCases {
      if componentType.rawValue == rawValue {
        self = componentType
        return
      }
    }
    //TODO: handle unknown components
    fatalError("Unknown Component.Type")
  }
}

extension IdentifiableComponent.ComponentType: CustomStringConvertible {
  public var description: String {
    switch self {
      case .anchoring:
        return "AnchoringComponent"

      case .characterController:
        return "CharacterControllerComponent"

      case .characterControllerState:
        return "CharacterControllerStateComponent"

      case .collision:
        return "CollisionComponent"

      case .directionalLight:
        return "DirectionalLightComponent"

      case .directionalLightShadow:
        return "DirectionalLightComponent.Shadow"

      case .model:
        return "ModelComponent"

      case .modelDebugOptions:
        return "ModelDebugOptionsComponent"

      case .perspectiveCamera:
        return "PerspectiveCameraComponent"

      case .physicsBody:
        return "PhysicsBodyComponent"

      case .physicsMotion:
        return "PhysicsMotionComponent"

      case .pointLight:
        return "PointLightComponent"

      case .spotLight:
        return "SpotLightComponent"

      case .spotLightShadow:
        return "SpotLightComponent.Shadow"

      case .synchronization:
        return "SynchronizationComponent"

      case .transform:
        return "Transform"
    }
  }
}

extension IdentifiableComponent.ComponentType {
  public var help: String {
    switch self {
      case .anchoring:
        return """
          A description of how virtual content can be anchored to the real world.
          """
      case .characterController:
        return """
          A component that manages character movement.
          """
      case .characterControllerState:
        return """
          An object that maintains state for a character controller.
          """
      case .collision:
        return """
          A component that gives an entity the ability to collide with other entities that also have collision components.
          """
      case .directionalLight:
        return """
          A component that defines a directional light source.
          """
      case .directionalLightShadow:
        return """
          Defines shadow characteristics for a directional light.
          """
      case .model:
        return """
          A collection of resources that create the visual appearance of an entity.
          """
      case .modelDebugOptions:
        return """
          A component that changes how RealityKit renders its entity to help with debugging.
          """
      case .perspectiveCamera:
        return """
          In AR applications, the camera is automatically provided by the system. In non-AR scenarios, the camera needs to be set by the app. (If no camera is provided by the app, the system will use default camera.)
          """
      case .physicsBody:
        return """
          A component that defines an entity’s behavior in physics body simulations.
          """
      case .physicsMotion:
        return """
          A component that controls the motion of the body in physics simulations.
          """
      case .pointLight:
        return """
          A component that defines a point light source.
          """
      case .spotLight:
        return """
          A component that defines a spotlight source.
          """
      case .spotLightShadow:
        return """
          Characteristics of a shadow for the spotlight.
          """
      case .synchronization:
        return """
          A component that synchronizes an entity between processes and networked applications.
          """
      case .transform:
        return """
          A component that defines the scale, rotation, and translation of an entity.
          """
    }
  }
}
