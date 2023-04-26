import Foundation
import RealityKit

public protocol ComponentPropertiesRepresentable {}

public struct AnchoringComponentProperties: ComponentPropertiesRepresentable {
    /// The kind of real world object to which the anchor entity should anchor.
    public let target: AnchoringComponent.Target
}

public struct CharacterControllerComponentProperties: ComponentPropertiesRepresentable {
    /// The capsule radius.
    ///
    /// Specify this value in the entity's coordinate system.
    public let radius: Float

    /// The capsule height.
    ///
    /// The capsule height includes radii and should be specified the entity's coordinate system.
    public let height: Float

    /// An added tolerance around the character capsule.
    ///
    /// A small skin, known as the *contact offset*, is maintained around the controller's volume to avoid
    /// rounding and precision issues with collision detection. Specify this value relative to the entity's
    /// coordinate system.
    public let skinWidth: Float

    /// The slope limit expressed as a limit angle in radians.
    ///
    /// This value represents the maximum slope that the character can move over. RealityKit applies this value
    /// to characters that are walking on static objects, but not when walking on kinematic or dynamic objects.
    public let slopeLimit: Float

    /// The maximum obstacle height that the controller can move over.
    ///
    /// Specify this value relative to the entity's coordinate system.
    public let stepLimit: Float

    /// Y axis direction relative to the physics origin.
    ///
    /// Rotates the object so that the vertical height is along the up vector.
    /// Vector must be normalized and specified in *physics space*, the coordinate system of the
    /// physics simulation.
    public let upVector: SIMD3<Float>

    /// The character's collision filter.
    ///
    /// For more information on using collision filters, see <doc://com.apple.documentation/realitykit/controlling-entity-collisions-in-realitykit/>.
    public let collisionFilter: CollisionFilter
}

public struct CharacterControllerStateComponentProperties: ComponentPropertiesRepresentable {
    /// The linear speed relative to the phyics origin. In physics space.
    public let velocity: SIMD3<Float>

    /// True if character controller is grounded, otherwise false.
    public let isOnGround: Bool
}

public struct CollisionComponentProperties: ComponentPropertiesRepresentable {
    /// A collection of shape resources that collectively represent the outer
    /// dimensions of an entity for the purposes of collision detection.
    public let shapes: [ShapeResource]

    /// The collision mode.
    public let mode: CollisionComponent.Mode

    /// The collision filter used to segregate entities into different collision
    /// groups.
    public let filter: CollisionFilter
}

public struct DirectionalLightComponentProperties: ComponentPropertiesRepresentable {
    /// The intensity of the directional light, measured in lumen per square
    /// meter.
    public let intensity: Float

    /// A Boolean that you use to control whether the directional light operates
    /// as a proxy for a real-world light.
    ///
    /// Set the value to `true` when you want the light to cast shadows on
    /// virtual content without illuminating anything in the scene. You can use
    /// this to create shadows on occlusion materials that accept dynamic
    /// lighting.
    public let isRealWorldProxy: Bool
}

public struct DirectionalLightShadowComponentProperties: ComponentPropertiesRepresentable {
    /// The depth bias for the shadow.
    public let depthBias: Float

    /// The maximum distance for the shadow.
    public let maximumDistance: Float
}

public struct ModelComponentProperties: ComponentPropertiesRepresentable {
    /// The mesh that defines the shape of the entity.
    ///
    /// For more information, see ``RealityKit/MeshResource``
    public let mesh: MeshResource

    /// The materials used by the model.
    ///
    /// Each ``RealityKit/MeshResource`` requires a set of materials. An entity that has no materials
    /// renders using a pink, striped material.  To determine the number of  materials a model entity requires
    /// , use `MeshResource.expectedMaterialCount`
    public let materials: [Material]

    /// A margin applied to an entity’s bounding box that determines object
    /// visibility.
    ///
    /// When determining which entities are currently visible, RealityKit tests
    /// each entity’s bounding box to see if it overlaps with the camera’s field
    /// of view (also known as the camera’s _frustum_). For efficiency, entities
    /// with a bounding box that don’t overlap the camera’s frustum aren’t
    /// rendered. Use this property to prevent RealityKit from incorrectly
    /// culling entities that use a ``CustomMaterial`` with a geometry modifier
    /// that moves vertices outside of the entity’s bounding box.
    ///
    /// RealityKit adds the value of `boundsMargin` to the bounding box before
    /// determining which entities are visible.
    public let boundsMargin: Float
}

public struct ModelDebugOptionsComponentProperties: ComponentPropertiesRepresentable {
    /// The part of the rendering process to display as the entity’s surface
    /// texture.
    public let visualizationMode: ModelDebugOptionsComponent.VisualizationMode
}

public struct PerspectiveCameraComponentProperties: ComponentPropertiesRepresentable {
    /// The minimum distance in meters from the camera that the camera can see.
    ///
    /// The value defaults to 1 centimeter. Always use a value greater than `0`
    /// and less than the value of ``PerspectiveCameraComponent/far``. The
    /// renderer clips any surface closer than the
    /// ``PerspectiveCameraComponent/near`` point.
    public let near: Float

    /// The maximum distance in meters from the camera that the camera can see.
    ///
    /// The value defaults to infinity. Always use a value greater than the
    /// value of ``PerspectiveCameraComponent/near``. The renderer clips any
    /// surface beyond the ``PerspectiveCameraComponent/far`` point.
    public let far: Float

    /// The camera’s total vertical field of view in degrees.
    ///
    /// This property contains the entire vertifical field of view for the
    /// camera in degrees. The system automatically calculates the horizontal
    /// field of view from this value to fit the aspect ratio of the device’s
    /// screen.
    ///
    /// This property defaults to `60` degrees.
    public let fieldOfViewInDegrees: Float
}

public struct PhysicsBodyComponentProperties: ComponentPropertiesRepresentable {
    /// The physics body’s mode, indicating how or if it moves.
    ///
    /// By default, this value is set to ``PhysicsBodyMode/dynamic``, meaning
    /// the body responds to forces.
    public let mode: PhysicsBodyMode

    /// The physics body’s mass properties, like inertia and center of mass.
    ///
    /// By default, the mass properties value is
    /// ``PhysicsMassProperties/default``, which matches the properties of a
    /// unit sphere with mass of 1 kilogram.
    public let massProperties: PhysicsMassProperties

    /// The physics body’s material properties, like friction.
    ///
    /// By default, the body’s material resource is set to
    /// ``PhysicsMaterialResource/default``, which provides a modest amount of
    /// friction and restitution (bounciness).
    public let material: PhysicsMaterialResource

    /// A tuple of Boolean values that you use to lock the position of the
    /// physics body along any of the three axes.
    ///
    /// You can restrict movement of the body along one or more axes by setting
    /// the corresponding item in the tuple to `true`. For example, if you set
    /// the `x` and the `z` items in the tuple to `true`, then the body can move
    /// only along the y-axis. By default, movement isn’t restricted.
    public let isTranslationLocked: (x: Bool, y: Bool, z: Bool)

    /// A tuple of Boolean values that you use to lock rotation of the physics
    /// body around any of the three axes.
    ///
    /// For any one of the three Booleans in the tuple that you set to `true`,
    /// rotation is restricted on the axis represented by that item. For
    /// example, if you set the `x` item to true, then the body can’t rotate
    /// around the x-axis. By default, rotation isn’t restricted.
    public let isRotationLocked: (x: Bool, y: Bool, z: Bool)

    /// A Boolean that controls whether the physics simulation performs
    /// continuous collision detection.
    ///
    /// Set the value to `true` to perform continuous collision detection. The
    /// value is `false` by default, indicating the simulation should apply
    /// discrete collision detection.
    ///
    /// Discrete collision detection considers only the position of a body once
    /// per rendered frame, or about every 16 milliseconds at 60 frames per
    /// second. Continuous collision detection considers the position of the
    /// body throughout the frame interval. The latter is more computationally
    /// expensive, but can help to avoid missing a collision for a quickly
    /// moving object, like a projectile.
    public let isContinuousCollisionDetectionEnabled: Bool
}

public struct PhysicsMotionComponentProperties: ComponentPropertiesRepresentable {
    /// The linear velocity of the body in the physics simulation.
    public let linearVelocity: SIMD3<Float>

    /// The angular velocity of the body around the center of mass.
    public let angularVelocity: SIMD3<Float>
}

public struct PointLightComponentProperties: ComponentPropertiesRepresentable {
    /// The intensity of the point light, measured in lumen.
    public let intensity: Float

    /// The point light attenuation radius in meters.
    ///
    /// At any distance greater from the light that's greater than this value, the light's
    /// intensity is zero.
    public let attenuationRadius: Float
}

public struct SpotLightComponentProperties: ComponentPropertiesRepresentable {
    /// The intensity of the spotlight measured in lumen.
    public let intensity: Float

    /// The inner angle of the spotlight in degrees.
    ///
    /// A spot light's `innerAngle` and `outerAngle` reflect the size of the light's cone, which shines
    /// relative to the entity's forward direction (0, 0, -1). The light is at full  intensity between 0° and
    /// `innerAngle`. RealityKit attenuates the  light's intensity between `innerAngle` and
    /// `outerAngle`.  Beyond `outerAngle`, the light intensity is `0.0`.
    public let innerAngleInDegrees: Float

    /// The outer angle of the spotlight in degrees.
    ///
    /// A spot light's `innerAngle` and `outerAngle` reflect the size of the light's cone, which shines
    /// relative to the entity's forward direction (0, 0, -1). The light is at full  intensity between 0° and
    /// `innerAngle`. RealityKit attenuates the  light's intensity between `innerAngle` and
    /// `outerAngle`.  Beyond `outerAngle`, the light intensity is `0.0`.
    public let outerAngleInDegrees: Float

    /// The attenuation radius in meters, after which the intensity of the
    /// spotlight is zero.
    public let attenuationRadius: Float
}

public struct SpotLightShadowComponentProperties: ComponentPropertiesRepresentable {}

public struct SynchronizationComponentProperties: ComponentPropertiesRepresentable {
    /// A unique identifier of an entity within a network session.
    public let identifier: UInt64

    /// A Boolean that indicates whether the calling process owns the entity.
    public let isOwner: Bool

    /// The entity’s transfer ownership mode.
    ///
    /// By default, the transfer mode is
    /// ``SynchronizationComponent/OwnershipTransferMode-swift.enum/autoAccept``.
    /// You can set it to
    /// ``SynchronizationComponent/OwnershipTransferMode-swift.enum/manual`` to
    /// require explicit confirmation of the request by your app.
    public let ownershipTransferMode: SynchronizationComponent.OwnershipTransferMode
}

public struct TransformProperties: ComponentPropertiesRepresentable {
    /// The scaling factor applied to the entity.
    public let scale: SIMD3<Float>

    /// The rotation of the entity specified as a unit quaternion.
    public let rotation: simd_quatf

    /// The position of the entity along the x, y, and z axes.
    public let translation: SIMD3<Float>

    /// The transform represented as a 4x4 matrix.
    ///
    /// The ``Transform`` component can’t represent all transforms that a
    /// general 4x4 matrix can represent. Using a 4x4 matrix to set the
    /// transform is therefore a lossy event that might result in certain
    /// transformations, like shear, being dropped.
    public let matrix: float4x4
}
