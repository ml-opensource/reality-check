//
//  ContentView.swift
//  Testbed
//
//  Created by Cristian Díaz on 19.05.23.
//

import RealityCheckConnect
import RealityKit
import SwiftUI

struct ContentView: View {
  let container = ARViewContainer()
  var body: some View {
    ZStack {
      container.edgesIgnoringSafeArea(.all)
      RealityCheckConnectView(container.arView)
    }
  }
}

//MARK: -

let worldOriginAnchor: AnchorEntity = {
  let anchor = AnchorEntity(world: [0, 0, -5])
  anchor.name = "Le Anchor"
  return anchor
}()

let dummyEntity: Entity = .init()
let dummyAnchor: AnchorEntity = .init(plane: .any)
let anotherDummyAnchor: AnchorEntity = .init(world: .zero)
let dummyDirectionalLight: DirectionalLight = .init()
let dummyPointLight: PointLight = .init()
let dummySpotLight: SpotLight = {
  let spotLight = SpotLight()
  spotLight.light.color = .white
  spotLight.light.intensity = 1_000_000
  spotLight.light.innerAngleInDegrees = 40
  spotLight.light.outerAngleInDegrees = 60
  spotLight.light.attenuationRadius = 10
  spotLight.shadow = SpotLightComponent.Shadow()
  spotLight.look(at: [1, 0, -4], from: [0, 5, -5], relativeTo: nil)
  return spotLight
}()
let dummyCamera: PerspectiveCamera = .init()
let dummyTriggerVolume: TriggerVolume = .init()
let dummDebugOptionsComponent: ModelDebugOptionsComponent = .init(visualizationMode: .normal)

let boxEntity: ModelEntity = {
  let modelEntity = ModelEntity(mesh: .generateBox(size: 1), materials: [customMaterial])
  modelEntity.name = "Le Box"
  modelEntity.modelDebugOptions = dummDebugOptionsComponent
  return modelEntity
}()

var balls: [ModelEntity] = []
var points: [SIMD3<Float>] = []

struct ARViewContainer: UIViewRepresentable {

  let arView = ARView(frame: .zero)

  private func random() {
    points = (0..<Int.random(in: 5...55))
      .map { _ in
        SIMD3<Float>(
          x: Float.random(in: -1...1),
          y: Float.random(in: 0...1),
          z: Float.random(in: -1...1)
        )
      }
  }

  func makeUIView(context: Context) -> ARView {

    // Load the "Box" scene from the "Experience" Reality File
    let boxAnchor = try! Experience.loadBox()

    // Add the box anchor to the scene
    arView.scene.anchors.append(boxAnchor)
    boxAnchor.addChild(boxEntity)
    arView.scene.anchors.append(worldOriginAnchor)
    arView.scene.anchors.append(dummyAnchor)

    // robot
    let robot_url = Bundle.main.url(forResource: "robot_walk_idle", withExtension: "usdz")!
    let robot = try! Entity.load(contentsOf: robot_url)
    robot.isAccessibilityElement = true
    robot.accessibilityLabel = "Le robot accessibilityLabel"
    robot.accessibilityDescription = ""
    robot.playAnimation(robot.availableAnimations[0].repeat(duration: .infinity))
    let anchor = AnchorEntity(plane: .any)
    anchor.name = "RobotAnchor"
    anchor.setPosition([0, 0, 0.5], relativeTo: boxEntity)
    anchor.addChild(robot)
    arView.scene.anchors.append(anchor)

    // toy
    let toy_car_url = Bundle.main.url(forResource: "toy_car", withExtension: "usdz")!
    let toy_car = try! Entity.load(contentsOf: toy_car_url)
    toy_car.setPosition([-0.5, 0, -0.25], relativeTo: nil)
    toy_car.setOrientation(.init(angle: 27, axis: [0, 1, 0]), relativeTo: nil)
    // toy_car.setScale(.one, relativeTo: robot)
    toy_car.addChild(dummySpotLight)
    toy_car.addChild(dummyPointLight)

    dummyAnchor.addChild(toy_car)

    random()
    return arView

  }

  func updateUIView(_ uiView: ARView, context: Context) {
    //Clean balls
    for ballEntity in balls {
      ballEntity.removeFromParent()
    }
    balls.removeAll()

    //Add balls
    for point in points {
      let ballEntity = ModelEntity(
        mesh: .generateSphere(radius: Float.random(in: 0.03...0.1)),
        materials: [SimpleMaterial(color: .cyan, isMetallic: true)]
      )
      ballEntity.position = point
      worldOriginAnchor.addChild(ballEntity)
      balls.append(ballEntity)
    }

    //OBB
    // let pointsFromAbove = points.map {
    //     CGPoint(
    //         x: CGFloat($0.x),
    //         y: CGFloat($0.z)
    //     )
    // }

    // let obb = boundingBoxClient.findOrientedBoundingBox(pointsFromAbove)
    let obb = worldOriginAnchor.visualBounds(relativeTo: boxEntity)
    boxEntity.model?.mesh = .generateBox(
      width: Float(obb.extents.x),
      height: worldOriginAnchor.scale.y,
      depth: Float(obb.extents.y)
    )

    // let transform = Transform(
    //     rotation: .init(
    //         angle: Float(
    //             obb.isAligned.boolValue
    //                 ? -obb.widthAngle
    //                 : obb.widthAngle
    //         ),
    //         axis: [0, 1, 0]
    //     ),
    //     translation: .init(
    //         x: Float(obb.center.x),
    //         y: worldOriginAnchor.scale.y / 2,
    //         z: Float(obb.center.y)
    //     )
    // )

    let transform = Transform(
      rotation: .init(angle: Float.random(in: 0...deg2rad(360)), axis: [0, 1, 0]),
      translation: .init(
        x: Float(obb.center.x),
        y: worldOriginAnchor.scale.y / 2,
        z: Float(obb.center.y)
      )
    )
    boxEntity.move(
      to: transform,
      relativeTo: worldOriginAnchor,
      duration: 0.25
    )
  }

}

var customMaterial: CustomMaterial = {
  guard let device = MTLCreateSystemDefaultDevice() else {
    fatalError("Error creating default metal device.")
  }
  do {
    let library = try device.makeDefaultLibrary(bundle: .main)
    let surfaceShader = CustomMaterial.SurfaceShader(
      named: "wireframe_shader",
      in: library
    )
    var customMaterial = try CustomMaterial(
      surfaceShader: surfaceShader,
      lightingModel: .clearcoat
    )
    customMaterial.faceCulling = .none
    return customMaterial
  } catch {
    fatalError(error.localizedDescription)
  }
}()

func deg2rad(_ number: Float) -> Float { number * .pi / 180 }

#if DEBUG
  struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
    }
  }
#endif
