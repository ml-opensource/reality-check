import RealityKit
import SwiftUI

#if os(iOS) && !os(xrOS)

  /// As it's not possible to deallocate `ARView` properly, we make sure to use the existing instance.
  /// More info:
  /// - [About memory leakage](https://stackoverflow.com/a/71844537/955845)
  /// - [How to deallocate RealityKit ARView()?](https://stackoverflow.com/a/59910004/955845)
  public class SingleARView {
    static let shared = SingleARView()
    public let arView = ARView(frame: .zero)
  }

  public struct RealityCheckConnectContainer: UIViewRepresentable {
    public let arView: ARView

    public init() {
      self.arView = SingleARView.shared.arView
    }

    public func makeUIView(context: Context) -> ARView {

      // Create a cube model
      let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
      let material = SimpleMaterial(color: .gray, roughness: 0.15, isMetallic: true)
      let model = ModelEntity(mesh: mesh, materials: [material])

      // Create horizontal plane anchor for the content
      let anchor = AnchorEntity(
        .plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2))
      )
      anchor.children.append(model)

      // Add the horizontal plane anchor to the scene
      arView.scene.anchors.append(anchor)

      // Add `RealityCheckConnectView` overlay
      arView.addRealityCheckConnectView()

      return arView

    }

    public func updateUIView(_ uiView: ARView, context: Context) {}

  }

  extension ARView {
    public func addRealityCheckConnectView() {
      let controller = UIHostingController(rootView: RealityCheckConnectView(self))
      controller.view.translatesAutoresizingMaskIntoConstraints = false
      controller.view.backgroundColor = .clear
      self.addSubview(controller.view)

      NSLayoutConstraint.activate([
        controller.view.widthAnchor.constraint(equalTo: self.widthAnchor),
        controller.view.heightAnchor.constraint(equalTo: self.heightAnchor),
        controller.view.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        controller.view.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      ])
    }
  }

#endif
