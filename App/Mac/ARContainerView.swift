import Foundation
import RealityKit
import SwiftUI

//MARK: -
let worldOriginAnchor: AnchorEntity = {
    let anchor = AnchorEntity(world: [0, 0, -5])
    anchor.name = "Le Anchor"
    return anchor
}()

let dummyEntity: Entity = .init()
let dummyAnchor: AnchorEntity = .init(world: .zero)
let anotherDummyAnchor: AnchorEntity = .init(world: .zero)
let dummyDirectionalLight: DirectionalLight = .init()
let dummyPointLight: PointLight = .init()
let dummySpotLight: SpotLight = .init()
let dummyCamera: PerspectiveCamera = .init()
let dummyTriggerVolume: TriggerVolume = .init()

let boxEntity = ModelEntity(mesh: .generateBox(size: 1), materials: [customMaterial])
var balls: [ModelEntity] = []

#if os(iOS)
    typealias ViewRepresentable = UIViewRepresentable
#elseif os(macOS)
    typealias ViewRepresentable = NSViewRepresentable
#endif

struct ARContainerView: ViewRepresentable {
    var points: [SIMD3<Float>]

    func makeNSView(context: Context) -> some NSView {
        let arView = ARView(frame: .zero)
        arView.environment.background = .color(.windowBackgroundColor)
        let skyboxName = "aerodynamics_workshop_4k.exr"
        let skyboxResource = try! EnvironmentResource.load(named: skyboxName)
        arView.environment.lighting.resource = skyboxResource
        arView.environment.background = .skybox(skyboxResource)

        arView.scene.anchors.append(worldOriginAnchor)
        arView.scene.anchors.append(dummyAnchor)
        worldOriginAnchor.setOrientation(
            .init(angle: deg2rad(35), axis: [1, 0, 0]), relativeTo: nil)
       
        let camera = PerspectiveCamera()
        camera.camera.fieldOfViewInDegrees = 60
        camera.look(
            at: .zero,
            from: .zero,
            relativeTo: worldOriginAnchor
        )
        
        worldOriginAnchor.addChild(boxEntity)

        let floor = ModelEntity(
            mesh: .generatePlane(width: 4, depth: 5),
            materials: [UnlitMaterial(color: .highlightColor)]
        )
        floor.position.y -= 0.1
        worldOriginAnchor.addChild(floor)

        boxEntity.addChild(dummyEntity)
        boxEntity.addChild(anotherDummyAnchor)
        anotherDummyAnchor.addChild(dummyDirectionalLight)
        anotherDummyAnchor.addChild(dummyPointLight)
        anotherDummyAnchor.addChild(dummySpotLight)
        worldOriginAnchor.addChild(dummyCamera)
        dummyCamera.addChild(dummyTriggerVolume)

        return arView
    }

    func updateNSView(_ nsView: NSViewType, context: Context) {
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
