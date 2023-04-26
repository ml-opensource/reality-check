import Foundation
import RealityKit

public struct IdentifiableComponent {

    public let componentType: ComponentType
    private(set) public var properties: any ComponentPropertiesRepresentable

    //TODO: include TransientComponent.self
    public enum ComponentType: CaseIterable {
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
                target: component.target
            )
            
        case .characterControllerComponent:
            let _c = component as! CharacterControllerComponent
            self.properties = CharacterControllerComponentProperties()

        case .characterControllerStateComponent:
            let _c = component as! CharacterControllerStateComponent
            self.properties = CharacterControllerStateComponentProperties()

        case .collisionComponent:
            let _c = component as! CollisionComponent
            self.properties = CollisionComponentProperties()

        case .directionalLightComponent:
            let _c = component as! DirectionalLightComponent
            self.properties = DirectionalLightComponentProperties()

        case .directionalLightComponentShadow:
            let _c = component as! DirectionalLightComponent.Shadow
            self.properties = DirectionalLightShadowComponentProperties()

        case .modelComponent:
            let component = component as! ModelComponent
            self.properties = ModelComponentProperties(
                mesh: component.mesh
            )
            
        case .modelDebugOptionsComponent:
            let _c = component as! ModelDebugOptionsComponent
            self.properties = ModelDebugOptionsComponentProperties()

        case .perspectiveCameraComponent:
            let _c = component as! PerspectiveCameraComponent
            self.properties = PerspectiveCameraComponentProperties()

        case .physicsBodyComponent:
            let _c = component as! PhysicsBodyComponent
            self.properties = PhysicsBodyComponentProperties()

        case .physicsMotionComponent:
            let _c = component as! PhysicsMotionComponent
            self.properties = PhysicsMotionComponentProperties()

        case .pointLightComponent:
            let _c = component as! PointLightComponent
            self.properties = PointLightComponentProperties()

        case .spotLightComponent:
            let _c = component as! SpotLightComponent
            self.properties = SpotLightComponentProperties()

        case .spotLightComponentShadow:
            let _c = component as! SpotLightComponent.Shadow
            self.properties = SpotLightShadowComponentProperties()

        case .synchronizationComponent:
            let _c = component as! SynchronizationComponent
            self.properties = SynchronizationComponentProperties()

        case .transform:
            let component = component as! Transform
            self.properties = TransformProperties(
                scale: component.scale,
                rotation: component.rotation,
                translation: component.translation,
                matrix: component.matrix
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
