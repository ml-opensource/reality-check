import Models
import RealityCodable
import SwiftUI

struct ComponentPropertiesView: View {
  let component: RealityPlatform.visionOS.Component

  init(
    _ component: RealityPlatform.visionOS.Component
  ) {
    self.component = component
  }

  var body: some View {
    switch component {
      case .accessibilityComponent(let value):
        VStack {
          // LabeledContent("Label", value: value.label ?? "...")
          // LabeledContent("Value", value: value.value ?? "...")
          // LabeledContent("CustomActions", value: value.customActions.debugDescription)
        }
      case .adaptiveResolutionComponent(let value):
        EmptyView()
      case .ambientAudioComponent(let value):
        EmptyView()
      case .anchoringComponent(let value):
        EmptyView()
      case .audioMixGroupsComponent(let value):
        EmptyView()
      case .channelAudioComponent(let value):
        EmptyView()
      case .characterControllerComponent(let value):
        EmptyView()
      case .characterControllerStateComponent(let value):
        EmptyView()
      case .collisionComponent(let value):
        EmptyView()
      case .groundingShadowComponent(let value):
        EmptyView()
      case .hoverEffectComponent(let value):
        EmptyView()
      case .imageBasedLightComponent(let value):
        EmptyView()
      case .imageBasedLightReceiverComponent(let value):
        EmptyView()
      case .inputTargetComponent(let value):
        EmptyView()
      case .modelComponent(let value):
        EmptyView()
      case .modelDebugOptionsComponent(let value):
        EmptyView()
      case .modelSortGroupComponent(let value):
        EmptyView()
      case .opacityComponent(let value):
        EmptyView()
      case .particleEmitterComponent(let value):
        EmptyView()
      case .perspectiveCameraComponent(let value):
        EmptyView()
      case .physicsBodyComponent(let value):
        EmptyView()
      case .physicsMotionComponent(let value):
        EmptyView()
      case .physicsSimulationComponent(let value):
        EmptyView()
      case .portalComponent(let value):
        EmptyView()
      case .sceneUnderstandingComponent(let value):
        EmptyView()
      case .spatialAudioComponent(let value):
        EmptyView()
      case .synchronizationComponent(let value):
        EmptyView()
      case .textComponent(let value):
        EmptyView()
      case .transform(let value):
        EmptyView()

      // VStack {
      //   LabeledContent("matrix", value: value.matrix)
      //   LabeledContent("rotation", value: value.rotation)
      //   LabeledContent("scale", value: value.scale)
      //   LabeledContent("translation", value: value.translation)
      // }

      case .videoPlayerComponent(let value):
        EmptyView()
      case .worldComponent(let value):
        EmptyView()
    }
  }

  //  var body: some View {
  //    switch component {
  //      case .anchoring(let properties):
  //        AnchoringComponentPropertiesView(properties)
  //
  //      case .characterController(let properties):
  //        CharacterControllerComponentPropertiesView(properties)
  //
  //      case .characterControllerState(let properties):
  //        CharacterControllerStateComponentPropertiesView(properties)
  //
  //      case .collision(let properties):
  //        CollisionComponentPropertiesView(properties)
  //
  //      case .directionalLight(let properties):
  //        DirectionalLightComponentPropertiesView(properties)
  //
  //      case .directionalLightShadow(let properties):
  //        DirectionalLightShadowComponentPropertiesView(properties)
  //
  //      case .model(let properties):
  //        ModelComponentPropertiesView(properties)
  //
  //      case .modelDebugOptions(let properties):
  //        ModelDebugOptionsComponentPropertiesView(properties)
  //
  //      case .perspectiveCamera(let properties):
  //        PerspectiveCameraComponentPropertiesView(properties)
  //
  //      case .physicsBody(let properties):
  //        PhysicsBodyComponentPropertiesView(properties)
  //
  //      case .physicsMotion(let properties):
  //        PhysicsMotionComponentPropertiesView(properties)
  //
  //      case .pointLight(let properties):
  //        PointLightComponentPropertiesView(properties)
  //
  //      case .spotLight(let properties):
  //        SpotLightComponentPropertiesView(properties)
  //
  //      case .spotLightShadow(let properties):
  //        SpotLightShadowComponentPropertiesView(properties)
  //
  //      case .synchronization(let properties):
  //        SynchronizationComponentPropertiesView(properties)
  //
  //      case .transform(let properties):
  //        TransformComponentPropertiesView(properties)
  //    }
  //  }
}

//struct AnchoringComponentPropertiesView: View {
//  let properties: AnchoringComponentProperties
//  private var targetDebugDescription: String {
//    switch properties.target {
//      case .camera:
//        return "camera"
//      case .world(let transform):
//        return "world(\(transform)"
//      case .anchor(let identifier):
//        return "anchor(identifier: \(identifier))"
//      case .plane(_, let classifications, let minimumBounds):
//        return "plane(_, \(classifications), \(minimumBounds))"
//      case .image(let group, let name):
//        return "image(\(group), \(name))"
//      case .object(let group, let name):
//        return "object(\(group), \(name))"
//      case .face:
//        return "face"
//      case .body:
//        return "body"
//    }
//  }
//
//  init(
//    _ properties: AnchoringComponentProperties
//  ) {
//    self.properties = properties
//  }
//
//  var body: some View {
//    LabeledContent(
//      "target",
//      value: targetDebugDescription
//    )
//  }
//}
//
//struct CharacterControllerComponentPropertiesView: View {
//  let properties: CharacterControllerComponentProperties
//
//  init(
//    _ properties: CharacterControllerComponentProperties
//  ) {
//    self.properties = properties
//  }
//
//  private var collisionFilterDebugDescription: String {
//    switch properties.collisionFilter.rawValue {
//      case .default:
//        return "default"
//      case .sensor:
//        return "sensor"
//      default:
//        return "unknown -> default"
//    }
//  }
//
//  var body: some View {
//    LabeledContent("radius", value: properties.radius.debugDescription)
//    LabeledContent("height", value: properties.height.debugDescription)
//    LabeledContent("skinWidth", value: properties.skinWidth.debugDescription)
//    LabeledContent("slopeLimit", value: properties.slopeLimit.debugDescription)
//    LabeledContent("stepLimit", value: properties.stepLimit.debugDescription)
//    LabeledContent("upVector", value: properties.upVector.debugDescription)
//    LabeledContent("collisionFilter", value: collisionFilterDebugDescription)
//  }
//}
//
//struct CharacterControllerStateComponentPropertiesView: View {
//  let properties: CharacterControllerStateComponentProperties
//
//  init(
//    _ properties: CharacterControllerStateComponentProperties
//  ) {
//    self.properties = properties
//  }
//
//  var body: some View {
//    LabeledContent("velocity", value: properties.velocity.debugDescription)
//    LabeledContent("isOnGround", value: properties.isOnGround ? "YES" : "NO")
//  }
//}
//
//struct CollisionComponentPropertiesView: View {
//  let properties: CollisionComponentProperties
//
//  private var modeDebugDescription: String {
//    switch properties.mode {
//      case .`default`:
//        return "default"
//      case .trigger:
//        return "trigger"
//    }
//  }
//
//  init(
//    _ properties: CollisionComponentProperties
//  ) {
//    self.properties = properties
//  }
//
//  var body: some View {
//    LabeledContent("shapes", value: properties.shapes.debugDescription)
//    LabeledContent("mode", value: modeDebugDescription)
//    //TODO: find a better way to display filters
//    GroupBox("filter") {
//      LabeledContent(
//        "group",
//        value: "\(properties.filter.group.collisionGroup.rawValue)"
//      )
//      .padding([.leading, .trailing, .top], 8)
//      LabeledContent(
//        "mask",
//        value: "\(properties.filter.mask.collisionGroup.rawValue)"
//      )
//      .padding([.leading, .trailing, .bottom], 8)
//    }
//  }
//}
//
//struct DirectionalLightComponentPropertiesView: View {
//  let properties: DirectionalLightComponentProperties
//
//  init(
//    _ properties: DirectionalLightComponentProperties
//  ) {
//    self.properties = properties
//  }
//
//  var body: some View {
//    LabeledContent("intensity", value: properties.intensity.debugDescription)
//    LabeledContent(
//      "isRealWorldProxy",
//      value: properties.isRealWorldProxy ? "YES" : "NO"
//    )
//  }
//}
//
//struct DirectionalLightShadowComponentPropertiesView: View {
//  let properties: DirectionalLightShadowComponentProperties
//
//  init(
//    _ properties: DirectionalLightShadowComponentProperties
//  ) {
//    self.properties = properties
//  }
//
//  var body: some View {
//    LabeledContent("depthBias", value: properties.depthBias.debugDescription)
//    LabeledContent(
//      "maximumDistance",
//      value: properties.maximumDistance.debugDescription
//    )
//  }
//}
//
//struct ModelComponentPropertiesView: View {
//  let properties: ModelComponentProperties
//
//  init(
//    _ properties: ModelComponentProperties
//  ) {
//    self.properties = properties
//  }
//
//  var body: some View {
//    LabeledContent("mesh", value: "properties.mesh")  //FIXME: find a way to display `mesh`
//    LabeledContent("materials", value: properties.materials.debugDescription)  //TODO: find a better way to display `materials`
//    LabeledContent("boundsMargin", value: properties.boundsMargin.debugDescription)
//  }
//}
//
//struct ModelDebugOptionsComponentPropertiesView: View {
//  let properties: ModelDebugOptionsComponentProperties
//
//  private var visualizationModeDebugDescription: String {
//    switch properties.visualizationMode {
//      case .none:
//        return "none"
//      case .normal:
//        return "normal"
//      case .tangent:
//        return "tangent"
//      case .bitangent:
//        return "bitangent"
//      case .baseColor:
//        return "baseColor"
//      case .textureCoordinates:
//        return "textureCoordinates"
//      case .finalColor:
//        return "finalColor"
//      case .finalAlpha:
//        return "finalAlpha"
//      case .roughness:
//        return "roughness"
//      case .metallic:
//        return "metallic"
//      case .ambientOcclusion:
//        return "ambientOcclusion"
//      case .specular:
//        return "specular"
//      case .emissive:
//        return "emissive"
//      case .clearcoat:
//        return "clearcoat"
//      case .clearcoatRoughness:
//        return "clearcoatRoughness"
//      case .lightingDiffuse:
//        return "lightingDiffuse"
//      case .lightingSpecular:
//        return "lightingSpecular"
//      @unknown default:
//        return "@unknown"
//    }
//  }
//  init(
//    _ properties: ModelDebugOptionsComponentProperties
//  ) {
//    self.properties = properties
//  }
//
//  var body: some View {
//    LabeledContent("visualizationMode", value: visualizationModeDebugDescription)
//  }
//}
//
//struct PerspectiveCameraComponentPropertiesView: View {
//  let properties: PerspectiveCameraComponentProperties
//
//  init(
//    _ properties: PerspectiveCameraComponentProperties
//  ) {
//    self.properties = properties
//  }
//
//  var body: some View {
//    LabeledContent("near", value: properties.near.debugDescription)
//    LabeledContent("far", value: properties.far.debugDescription)
//    LabeledContent(
//      "fieldOfViewInDegrees",
//      value: properties.fieldOfViewInDegrees.debugDescription
//    )
//  }
//}
//
//struct PhysicsBodyComponentPropertiesView: View {
//  let properties: PhysicsBodyComponentProperties
//
//  private var modeDebugDescription: String {
//    switch properties.mode {
//      case .static:
//        return "static"
//      case .kinematic:
//        return "kinematic"
//      case .dynamic:
//        return "dynamic"
//    }
//  }
//
//  init(
//    _ properties: PhysicsBodyComponentProperties
//  ) {
//    self.properties = properties
//  }
//
//  var body: some View {
//    LabeledContent("mode", value: modeDebugDescription)
//    //FIXME: Restore "massProperties" display
//    /*
//    GroupBox("massProperties") {
//      LabeledContent("inertia", value: properties.massProperties.inertia.debugDescription)
//      GroupBox("centerOfMass") {
//        LabeledContent(
//          "orientation",
//          value: properties.massProperties.centerOfMass.orientation.debugDescription)
//        LabeledContent(
//          "orientation",
//          value: properties.massProperties.centerOfMass.position.debugDescription)
//      }
//      LabeledContent("mass", value: properties.massProperties.mass.debugDescription)
//    }
//     */
//
//    LabeledContent("material", value: "properties.material")  //FIXME: find a way to display `material`
//    LabeledContent(
//      "isTranslationLocked",
//      value:
//        "(x: \(properties.isTranslationLocked.x), y: \(properties.isTranslationLocked.y), z: \(properties.isTranslationLocked.z))"
//    )
//    LabeledContent(
//      "isRotationLocked",
//      value:
//        "(x: \(properties.isRotationLocked.x), y: \(properties.isRotationLocked.y), z: \(properties.isRotationLocked.z))"
//    )
//    LabeledContent(
//      "isContinuousCollisionDetectionEnabled",
//      value: properties.isContinuousCollisionDetectionEnabled ? "YES" : "NO"
//    )
//  }
//}
//
//struct PhysicsMotionComponentPropertiesView: View {
//  let properties: PhysicsMotionComponentProperties
//
//  init(
//    _ properties: PhysicsMotionComponentProperties
//  ) {
//    self.properties = properties
//  }
//
//  var body: some View {
//    LabeledContent("linearVelocity", value: properties.linearVelocity.debugDescription)
//    LabeledContent(
//      "angularVelocity",
//      value: properties.angularVelocity.debugDescription
//    )
//  }
//}
//
//struct PointLightComponentPropertiesView: View {
//  let properties: PointLightComponentProperties
//
//  init(
//    _ properties: PointLightComponentProperties
//  ) {
//    self.properties = properties
//  }
//
//  var body: some View {
//    LabeledContent("intensity", value: properties.intensity.debugDescription)
//    LabeledContent(
//      "attenuationRadius",
//      value: properties.attenuationRadius.debugDescription
//    )
//  }
//}
//
//struct SpotLightComponentPropertiesView: View {
//  let properties: SpotLightComponentProperties
//
//  init(
//    _ properties: SpotLightComponentProperties
//  ) {
//    self.properties = properties
//  }
//
//  var body: some View {
//    LabeledContent("intensity", value: properties.innerAngleInDegrees.debugDescription)
//    LabeledContent(
//      "outerAngleInDegrees",
//      value: properties.attenuationRadius.debugDescription
//    )
//    LabeledContent("intensity", value: properties.innerAngleInDegrees.debugDescription)
//    LabeledContent(
//      "outerAngleInDegrees",
//      value: properties.attenuationRadius.debugDescription
//    )
//  }
//}
//
//struct SpotLightShadowComponentPropertiesView: View {
//  let properties: SpotLightShadowComponentProperties
//
//  init(
//    _ properties: SpotLightShadowComponentProperties
//  ) {
//    self.properties = properties
//  }
//
//  var body: some View {
//    Text("No properties are available.")
//  }
//}
//
//struct SynchronizationComponentPropertiesView: View {
//  let properties: SynchronizationComponentProperties
//
//  private var ownershipTransferModeDebugDescription: String {
//    switch properties.ownershipTransferMode {
//      case .autoAccept:
//        return "autoAccept"
//      case .manual:
//        return "manual"
//    }
//  }
//
//  init(
//    _ properties: SynchronizationComponentProperties
//  ) {
//    self.properties = properties
//  }
//
//  var body: some View {
//    LabeledContent("identifier", value: properties.isOwner ? "YES" : "NO")
//    LabeledContent("ownershipTransferMode", value: properties.identifier.description)
//    LabeledContent("isOwner", value: ownershipTransferModeDebugDescription)
//  }
//}
//
//struct TransformComponentPropertiesView: View {
//  let properties: TransformComponentProperties
//
//  init(
//    _ properties: TransformComponentProperties
//  ) {
//    self.properties = properties
//  }
//
//  var body: some View {
//    LabeledContent("matrix", value: properties.matrix.debugDescription)
//    LabeledContent("rotation", value: properties.rotation.debugDescription)
//    LabeledContent("scale", value: properties.scale.debugDescription)
//    LabeledContent("translation", value: properties.translation.debugDescription)
//  }
//}
