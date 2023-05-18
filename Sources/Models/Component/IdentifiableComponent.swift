import Foundation
import RealityKit

public struct IdentifiableComponent {

	public let componentType: ComponentType
	private(set) public var properties: any ComponentPropertiesRepresentable

	//TODO: include TransientComponent.self
	public enum ComponentType: CaseIterable, Codable {
		case anchoringComponent
		case characterControllerComponent
		case characterControllerStateComponent
		case collisionComponent
		case directionalLightComponent
		case directionalLightComponentShadow
		case modelComponent
		case modelDebugOptionsComponent
		case perspectiveCameraComponent
		case physicsBodyComponent
		case physicsMotionComponent
		case pointLightComponent
		case spotLightComponent
		case spotLightComponentShadow
		case synchronizationComponent
		case transform
	}

	public init(_ component: RealityKit.Component) {
		//FIXME: handle errors
		self.componentType = ComponentType(rawValue: Swift.type(of: component))!

		switch self.componentType {
		case .anchoringComponent:
			let component = component as! AnchoringComponent
			self.properties = AnchoringComponentProperties(
				target: CodableTarget(component.target)
			)

		case .characterControllerComponent:
			let component = component as! CharacterControllerComponent
			self.properties = CharacterControllerComponentProperties(
				radius: component.radius,
				height: component.height,
				skinWidth: component.skinWidth,
				slopeLimit: component.slopeLimit,
				stepLimit: component.stepLimit,
				upVector: component.upVector,
				collisionFilter: CodableCollisionFilter(component.collisionFilter)
			)

		case .characterControllerStateComponent:
			let component = component as! CharacterControllerStateComponent
			self.properties = CharacterControllerStateComponentProperties(
				velocity: component.velocity,
				isOnGround: component.isOnGround
			)

		case .collisionComponent:
			let component = component as! CollisionComponent
			self.properties = CollisionComponentProperties(
        shapes: component.shapes.map(CodableShapeResource.init),
				mode: CodableCollisionComponentMode(component.mode),
				filter: CodableCollisionFilter(component.filter)
			)

		case .directionalLightComponent:
			let component = component as! DirectionalLightComponent
			self.properties = DirectionalLightComponentProperties(
				intensity: component.intensity,
				isRealWorldProxy: component.isRealWorldProxy
			)

		case .directionalLightComponentShadow:
			let component = component as! DirectionalLightComponent.Shadow
			self.properties = DirectionalLightShadowComponentProperties(
				depthBias: component.depthBias,
				maximumDistance: component.maximumDistance
			)

		case .modelComponent:
			let component = component as! ModelComponent
			self.properties = ModelComponentProperties(
				mesh: CodableMeshResource(component.mesh),
				materials: component.materials.map(CodableMaterial.init),
				boundsMargin: component.boundsMargin
			)

		case .modelDebugOptionsComponent:
			let component = component as! ModelDebugOptionsComponent
			self.properties = ModelDebugOptionsComponentProperties(
				visualizationMode: component.visualizationMode
			)

		case .perspectiveCameraComponent:
			let component = component as! PerspectiveCameraComponent
			self.properties = PerspectiveCameraComponentProperties(
				near: component.near,
				far: component.far,
				fieldOfViewInDegrees: component.fieldOfViewInDegrees
			)

		case .physicsBodyComponent:
			let component = component as! PhysicsBodyComponent
			self.properties = PhysicsBodyComponentProperties(
				mode: CodablePhysicsBodyMode(component.mode),
				//FIXME: massProperties: component.massProperties,
				//FIXME: material: component.material,
				isTranslationLocked: MovementLock(component.isTranslationLocked),
				isRotationLocked: MovementLock(component.isRotationLocked),
				isContinuousCollisionDetectionEnabled: component
					.isContinuousCollisionDetectionEnabled
			)

		case .physicsMotionComponent:
			let component = component as! PhysicsMotionComponent
			self.properties = PhysicsMotionComponentProperties(
				linearVelocity: component.linearVelocity,
				angularVelocity: component.angularVelocity
			)

		case .pointLightComponent:
			let component = component as! PointLightComponent
			self.properties = PointLightComponentProperties(
				intensity: component.intensity,
				attenuationRadius: component.attenuationRadius
			)

		case .spotLightComponent:
			let component = component as! SpotLightComponent
			self.properties = SpotLightComponentProperties(
				intensity: component.intensity,
				innerAngleInDegrees: component.innerAngleInDegrees,
				outerAngleInDegrees: component.outerAngleInDegrees,
				attenuationRadius: component.attenuationRadius
			)

		case .spotLightComponentShadow:
			// As of RealityKit 2.0, it was empty.
			// let component = component as! SpotLightComponent.Shadow
			self.properties = SpotLightShadowComponentProperties()

		case .synchronizationComponent:
			let component = component as! SynchronizationComponent
			self.properties = SynchronizationComponentProperties(
				identifier: component.identifier,
				isOwner: component.isOwner,
				ownershipTransferMode: CodableOwnershipTransferMode(
					component.ownershipTransferMode)
			)

		case .transform:
			let component = component as! Transform
			self.properties = TransformProperties(
				scale: component.scale,
				rotation: CodableQuaternion(component.rotation),
				translation: component.translation,
				matrix: CodableFloat4x4(component.matrix)
			)
		}
	}
}

//MARK: -

extension IdentifiableComponent: Equatable, Hashable {
	public static func == (lhs: IdentifiableComponent, rhs: IdentifiableComponent) -> Bool {
		lhs.componentType == rhs.componentType
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(componentType)
	}
}
