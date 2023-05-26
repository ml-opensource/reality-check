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
        Toggle("Anchor Geometry", isOn: viewStore.binding(\.$showAnchorGeometry))
        Toggle("Anchor Origins", isOn: viewStore.binding(\.$showAnchorOrigins))
        Toggle("Feature Points", isOn: viewStore.binding(\.$showFeaturePoints))
        Toggle("Physics", isOn: viewStore.binding(\.$showPhysics))
        //TODO: find a way to verify this value
        // Toggle(
        //   "Scene Reconstruction",
        //   isOn: viewStore.binding(\.$showSceneUnderstanding)
        // )
        //.disabled(!ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh))
        Toggle("Statistics", isOn: viewStore.binding(\.$showStatistics))
        Toggle("World Origin", isOn: viewStore.binding(\.$showWorldOrigin))
      }
    }
  }
}
