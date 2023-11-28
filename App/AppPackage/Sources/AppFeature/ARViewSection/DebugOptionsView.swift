import ComposableArchitecture
import SwiftUI

public struct DebugOptionsView: View {
  @State var store: StoreOf<DebugOptions>

  public init(
    store: StoreOf<DebugOptions>
  ) {
    self.store = store
  }

  public var body: some View {
    Form {
      Section(
        content: {
          Toggle("Anchor Geometry", isOn: $store.showAnchorGeometry)
            .help("Display anchor geometry.")

          Toggle("Anchor Origins", isOn: $store.showAnchorOrigins)
            .help("Display anchor origins.")

          Toggle("Feature Points", isOn: $store.showFeaturePoints)
            .help(
              "Display a point cloud showing intermediate results of the scene analysis used to track device position."
            )

          Toggle("Physics", isOn: $store.showPhysics)
            .help("Draw visualizations for collision objects and rigid bodies.")

          //TODO: find a way to verify this value
          // Toggle("Scene Reconstruction", isOn: viewStore.binding(\.$showSceneUnderstanding))
          //   .help("Display the depth-colored wireframe for scene understanding meshes.")
          //   .disabled(!ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh))

          Toggle("Statistics", isOn: $store.showStatistics)
            .help("Collect performance statistics and display them in the view.")

          Toggle("World Origin", isOn: $store.showWorldOrigin)
            .help(
              "Display a coordinate axis indicating the position and orientation of the AR world coordinate system."
            )
        }
      )
    }
  }
}
