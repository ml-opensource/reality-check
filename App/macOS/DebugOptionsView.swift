import AppFeature
import ComposableArchitecture
import SwiftUI

public struct DebugOptionsView: View {
  let store: StoreOf<ARViewOptions>

  public init(
    store: StoreOf<ARViewOptions>
  ) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(
      self.store.scope(
        state: \.debugOptions,
        action: ARViewOptions.Action.debugOptions
      ),
      observe: { $0 }
    ) { viewStore in
      Form {
        Section(
          content: {
            Toggle("Anchor Geometry", isOn: viewStore.binding(\.$showAnchorGeometry))
              .help("Display anchor geometry.")
            Toggle("Anchor Origins", isOn: viewStore.binding(\.$showAnchorOrigins))
              .help("Display anchor origins.")
            Toggle("Feature Points", isOn: viewStore.binding(\.$showFeaturePoints))
              .help(
                "Display a point cloud showing intermediate results of the scene analysis used to track device position."
              )
            Toggle("Physics", isOn: viewStore.binding(\.$showPhysics))
              .help("Draw visualizations for collision objects and rigid bodies.")
            //TODO: find a way to verify this value
            // Toggle("Scene Reconstruction", isOn: viewStore.binding(\.$showSceneUnderstanding))
            //   .help("Display the depth-colored wireframe for scene understanding meshes.")
            //   .disabled(!ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh))
            Toggle("Statistics", isOn: viewStore.binding(\.$showStatistics))
              .help("Collect performance statistics and display them in the view.")
            Toggle("World Origin", isOn: viewStore.binding(\.$showWorldOrigin))
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
