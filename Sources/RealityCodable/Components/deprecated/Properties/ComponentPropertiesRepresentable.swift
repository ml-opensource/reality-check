import Foundation

/// A protocol that represents a Component type whose properties can be encoded and decoded using the `Codable` protocol.
///
/// Types conforming to `ComponentPropertiesRepresentable` can be used as properties within components that adopt the `Component` protocol. By conforming to `Codable`, the properties of the type can be easily serialized to and deserialized from various formats such as JSON or binary.
///
/// When conforming to `ComponentPropertiesRepresentable`, ensure that all properties of the type also conform to `Codable`.
///
/// Example:
/// ```
/// struct Position: ComponentPropertiesRepresentable {
///     var x: Float
///     var y: Float
/// }
///
/// struct Entity: Component {
///     var position: Position
/// }
///
/// let entity = Entity(position: Position(x: 10.0, y: 5.0))
///
/// let encoder = JSONEncoder()
/// let data = try encoder.encode(entity)
///
/// let decoder = JSONDecoder()
/// let decodedEntity = try decoder.decode(Entity.self, from: data)
/// ```
public protocol ComponentPropertiesRepresentable: Codable {}

public enum ComponentProperties: Codable {
  case anchoring(AnchoringComponentProperties)
  case characterController(CharacterControllerComponentProperties)
  case characterControllerState(CharacterControllerStateComponentProperties)
  case collision(CollisionComponentProperties)
  case directionalLight(DirectionalLightComponentProperties)
  case directionalLightShadow(DirectionalLightShadowComponentProperties)
  case model(ModelComponentProperties)
  case modelDebugOptions(ModelDebugOptionsComponentProperties)
  case perspectiveCamera(PerspectiveCameraComponentProperties)
  case physicsBody(PhysicsBodyComponentProperties)
  case physicsMotion(PhysicsMotionComponentProperties)
  case pointLight(PointLightComponentProperties)
  case spotLight(SpotLightComponentProperties)
  case spotLightShadow(SpotLightShadowComponentProperties)
  case synchronization(SynchronizationComponentProperties)
  case transform(TransformComponentProperties)
}
