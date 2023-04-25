import Dependencies
import Models
import RealityDumpClient
import RealityKit
import SwiftUI

struct ContentView: View {
    @State private var points: [SIMD3<Float>] = []
    @State private var text: String = """
        Biscuit dessert tart gummi bears pie biscuit. Pastry oat cake fruitcake chocolate cake marzipan shortbread pie toffee muffin. Marshmallow biscuit muffin sesame snaps chocolate cake candy tart. Tart biscuit croissant tiramisu powder chocolate cake chocolate bar candy canes.
        """

    @State private var identifiedEntities: [IdentifiableEntity] = []
    @State private var selection: IdentifiableEntity? = nil  // Nothing selected by default.

    @Dependency(\.realityDump) var realityDump

    var body: some View {
        NavigationSplitView {
            List(identifiedEntities, children: \.children, selection: $selection) { entity in
                NavigationLink.init(
                    value: entity,
                    label: {
                        Label(
                            entity.type.description,
                            systemImage: entity.type.symbol
                        )
                    }
                )
            }
        } content: {
            VSplitView {
                ARContainerView(points: points)
                    .ignoresSafeArea()
                    .overlay(alignment: .bottom) {
                        HStack {
                            Button("Random") {
                                random()
                            }
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)
                        }.padding()
                    }
                    .task {
                        random()
                    }

                TextEditor(text: $text)
                    .monospaced()
                    // .font(.custom("Menlo", size: 14.0))
                    // .lineSpacing(10.0)
                    .foregroundColor(.cyan)
                    .multilineTextAlignment(.leading)
            }
        } detail: {
            Group {
                if let entity = selection {
                    EntityDetailView(entity: entity)
                } else {
                    Text("Pick an entity")
                }
            }
            // .navigationSplitViewColumnWidth(270)
        }
        .toolbar {
            Button(
                action: {
                    Task {
                        text = await realityDump.raw(
                            worldOriginAnchor,
                            printing: false,
                            org: false
                        )
                        .joined(separator: "\n")

                        identifiedEntities = await realityDump.identify(worldOriginAnchor)
                    }
                },
                label: { Label("Dump", systemImage: "ladybug") }
            )
        }
    }

    private func random() {
        points = (0..<Int.random(in: 5...55)).map { _ in
            SIMD3<Float>(
                x: Float.random(in: -1...1),
                y: Float.random(in: 0...1),
                z: Float.random(in: -1...1)
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//MARK: -
let worldOriginAnchor: AnchorEntity = {
    let anchor = AnchorEntity(world: [0, 0, -5])
    anchor.name = "Le Anchor"
    return anchor
}()
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

        boxEntity.addChild(Entity())
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
