import RealityKit

public struct CodableComponent: Codable {

  public let componentType: ComponentType
  private(set) public var properties: ComponentProperties

  //TODO: include TransientComponent.self
  public enum ComponentType: CaseIterable, Codable {
    case anchoring
    case characterController
    case characterControllerState
    case collision
    case directionalLight
    case directionalLightShadow
    case model
    case modelDebugOptions
    case perspectiveCamera
    case physicsBody
    case physicsMotion
    case pointLight
    case spotLight
    case spotLightShadow
    case synchronization
    case transform
  }

  public init(
    _ component: RealityKit.Component
  ) {
    //FIXME: handle errors
    self.componentType = ComponentType(rawValue: Swift.type(of: component))!
    switch self.componentType {
      case .anchoring:
        let component = component as! AnchoringComponent
        self.properties = .anchoring(
          AnchoringComponentProperties(
            target: CodableTarget(component.target)
          )
        )

      case .characterController:
        let component = component as! CharacterControllerComponent
        self.properties = .characterController(
          CharacterControllerComponentProperties(
            radius: component.radius,
            height: component.height,
            skinWidth: component.skinWidth,
            slopeLimit: component.slopeLimit,
            stepLimit: component.stepLimit,
            upVector: component.upVector,
            collisionFilter: CodableCollisionFilter(
              component.collisionFilter
            )
          )
        )

      case .characterControllerState:
        let component = component as! CharacterControllerStateComponent
        self.properties = .characterControllerState(
          CharacterControllerStateComponentProperties(
            velocity: component.velocity,
            isOnGround: component.isOnGround
          )
        )

      case .collision:
        let component = component as! CollisionComponent
        self.properties = .collision(
          CollisionComponentProperties(
            shapes: component.shapes.map(CodableShapeResource.init),
            mode: CodableCollisionComponentMode(component.mode),
            filter: CodableCollisionFilter(component.filter)
          )
        )

      case .directionalLight:
        #if os(iOS) && !os(xrOS)
          let component = component as! DirectionalLightComponent
          self.properties = .directionalLight(
            DirectionalLightComponentProperties(
              intensity: component.intensity,
              isRealWorldProxy: component.isRealWorldProxy
            )
          )
        #else
          //FIXME: xrOS compatibility
          fatalError()
        #endif

      case .directionalLightShadow:
        #if os(iOS) && !os(xrOS)
          let component = component as! DirectionalLightComponent.Shadow
          self.properties = .directionalLightShadow(
            DirectionalLightShadowComponentProperties(
              depthBias: component.depthBias,
              maximumDistance: component.maximumDistance
            )
          )
        #else
          //FIXME: xrOS compatibility
          fatalError()
        #endif

      case .model:
        let component = component as! ModelComponent
        self.properties = .model(
          ModelComponentProperties(
            mesh: CodableMeshResource(component.mesh),
            materials: component.materials.map(CodableMaterial.init),
            boundsMargin: component.boundsMargin
          )
        )

      case .modelDebugOptions:
        let component = component as! ModelDebugOptionsComponent
        self.properties = .modelDebugOptions(
          ModelDebugOptionsComponentProperties(
            visualizationMode: component.visualizationMode
          )
        )

      case .perspectiveCamera:
        let component = component as! PerspectiveCameraComponent
        self.properties = .perspectiveCamera(
          PerspectiveCameraComponentProperties(
            near: component.near,
            far: component.far,
            fieldOfViewInDegrees: component.fieldOfViewInDegrees
          )
        )

      case .physicsBody:
        let component = component as! PhysicsBodyComponent
        self.properties = .physicsBody(
          PhysicsBodyComponentProperties(
            mode: CodablePhysicsBodyMode(component.mode),
            //FIXME: massProperties: component.massProperties,
            //FIXME: material: component.material,
            isTranslationLocked: MovementLock(
              component.isTranslationLocked
            ),
            isRotationLocked: MovementLock(component.isRotationLocked),
            isContinuousCollisionDetectionEnabled: component
              .isContinuousCollisionDetectionEnabled
          )
        )

      case .physicsMotion:
        let component = component as! PhysicsMotionComponent
        self.properties = .physicsMotion(
          PhysicsMotionComponentProperties(
            linearVelocity: component.linearVelocity,
            angularVelocity: component.angularVelocity
          )
        )

      case .pointLight:
        #if os(iOS) && !os(xrOS)
          let component = component as! PointLightComponent
          self.properties = .pointLight(
            PointLightComponentProperties(
              intensity: component.intensity,
              attenuationRadius: component.attenuationRadius
            )
          )
        #else
          //FIXME: xrOS compatibility
          fatalError()
        #endif

      case .spotLight:
        #if os(iOS) && !os(xrOS)
          let component = component as! SpotLightComponent
          self.properties = .spotLight(
            SpotLightComponentProperties(
              intensity: component.intensity,
              innerAngleInDegrees: component.innerAngleInDegrees,
              outerAngleInDegrees: component.outerAngleInDegrees,
              attenuationRadius: component.attenuationRadius
            )
          )
        #else
          //FIXME: xrOS compatibility
          fatalError()
        #endif

      case .spotLightShadow:
        // As of RealityKit 2.0, it was empty.
        // let component = component as! SpotLightComponent.Shadow
        self.properties = .spotLightShadow(SpotLightShadowComponentProperties())

      case .synchronization:
        let component = component as! SynchronizationComponent
        self.properties = .synchronization(
          SynchronizationComponentProperties(
            identifier: component.identifier,
            isOwner: component.isOwner,
            ownershipTransferMode: CodableOwnershipTransferMode(
              component.ownershipTransferMode
            )
          )
        )

      case .transform:
        let component = component as! Transform
        self.properties = .transform(
          TransformComponentProperties(
            scale: component.scale,
            rotation: CodableQuaternion(component.rotation),
            translation: component.translation,
            matrix: CodableFloat4x4(component.matrix)
          )
        )
    }
  }
}

//MARK: -

extension CodableComponent: Equatable, Hashable {
  public static func == (lhs: CodableComponent, rhs: CodableComponent) -> Bool {
    lhs.componentType == rhs.componentType
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(componentType)
  }
}

//FIXME:
//extension IdentifiableComponent: CustomDumpReflectable {
//  public var customDumpMirror: Mirror {
//    .init(
//      self.properties,
//      children: [
//        "componentType": self.componentType,
//        "properties": self.properties,
//      ],
//      displayStyle: .struct
//    )
//  }
//}

//extension IdentifiableComponent: CustomDumpRepresentable {
//  public var customDumpValue: Any {
//    switch self.properties {
//      case .anchoring(let value):
//        return value
//
//      case .characterController(let value):
//        return value
//
//      case .characterControllerState(let value):
//        return value
//
//      case .collision(let value):
//        return value
//
//      case .directionalLight(let value):
//        return value
//
//      case .directionalLightShadow(let value):
//        return value
//
//      case .model(let value):
//        return value
//
//      case .modelDebugOptions(let value):
//        return value
//
//      case .perspectiveCamera(let value):
//        return value
//
//      case .physicsBody(let value):
//        return value
//
//      case .physicsMotion(let value):
//        return value
//
//      case .pointLight(let value):
//        return value
//
//      case .spotLight(let value):
//        return value
//
//      case .spotLightShadow(let value):
//        return value
//
//      case .synchronization(let value):
//        return value
//
//      case .transform(let value):
//        return value
//
//    }
//  }
//}
