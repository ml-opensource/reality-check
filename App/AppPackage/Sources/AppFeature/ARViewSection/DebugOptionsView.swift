import ComposableArchitecture
import SwiftUI

public struct DebugOptionsView: View {
  let store: StoreOf<DebugOptions>

  public init(
    store: StoreOf<DebugOptions>
  ) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      Form {
        Section(
          content: {
            Toggle("Anchor Geometry", isOn: viewStore.$showAnchorGeometry)
              .help("Display anchor geometry.")

            Toggle("Anchor Origins", isOn: viewStore.$showAnchorOrigins)
              .help("Display anchor origins.")

            Toggle("Feature Points", isOn: viewStore.$showFeaturePoints)
              .help(
                "Display a point cloud showing intermediate results of the scene analysis used to track device position."
              )

            Toggle("Physics", isOn: viewStore.$showPhysics)
              .help("Draw visualizations for collision objects and rigid bodies.")

            //TODO: find a way to verify this value
            // Toggle("Scene Reconstruction", isOn: viewStore.binding(\.$showSceneUnderstanding))
            //   .help("Display the depth-colored wireframe for scene understanding meshes.")
            //   .disabled(!ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh))

            Toggle("Statistics", isOn: viewStore.$showStatistics)
              .help("Collect performance statistics and display them in the view.")

            Toggle("World Origin", isOn: viewStore.$showWorldOrigin)
              .help(
                "Display a coordinate axis indicating the position and orientation of the AR world coordinate system."
              )
          },
          header: {
            Text("ARView Debug Options")
              .font(.headline)
          }
        )
      }
    }
  }
}
