import Foundation
import RealityKit

public protocol ComponentPropertiesRepresentable {}

public struct AnchoringComponentProperties: ComponentPropertiesRepresentable {
    public let target: AnchoringComponent.Target
}
public struct CharacterControllerComponentProperties: ComponentPropertiesRepresentable {}
public struct CharacterControllerStateComponentProperties: ComponentPropertiesRepresentable {}
public struct CollisionComponentProperties: ComponentPropertiesRepresentable {}
public struct DirectionalLightComponentProperties: ComponentPropertiesRepresentable {}
public struct DirectionalLightShadowComponentProperties: ComponentPropertiesRepresentable {}
public struct ModelComponentProperties: ComponentPropertiesRepresentable {
    public let mesh: MeshResource
}
public struct ModelDebugOptionsComponentProperties: ComponentPropertiesRepresentable {}
public struct PerspectiveCameraComponentProperties: ComponentPropertiesRepresentable {}
public struct PhysicsBodyComponentProperties: ComponentPropertiesRepresentable {}
public struct PhysicsMotionComponentProperties: ComponentPropertiesRepresentable {}
public struct PointLightComponentProperties: ComponentPropertiesRepresentable {}
public struct SpotLightComponentProperties: ComponentPropertiesRepresentable {}
public struct SpotLightShadowComponentProperties: ComponentPropertiesRepresentable {}
public struct SynchronizationComponentProperties: ComponentPropertiesRepresentable {}
public struct TransformProperties: ComponentPropertiesRepresentable {
    /// The scaling factor applied to the entity.
    public let scale: SIMD3<Float>
    /// The rotation of the entity specified as a unit quaternion.
    public let rotation: simd_quatf
    /// The position of the entity along the x, y, and z axes.
    public let translation: SIMD3<Float>
    /// The transform represented as a 4x4 matrix.
    public let matrix: float4x4
}
public struct EmptyComponentProperties: ComponentPropertiesRepresentable {}
