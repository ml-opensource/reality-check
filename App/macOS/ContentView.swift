import AppFeature
import ComposableArchitecture
import Dependencies
import Models
import StreamingClient
import SwiftUI

struct ContentView: View {
  @State private var points: [SIMD3<Float>] = []
  let store: StoreOf<AppCore>

  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      NavigationSplitView {
        Sidebar(viewStore: viewStore)
      } content: {
        StreamingView()

        // VSplitView {
        //   ARContainerView(points: points)
        //     .overlay(alignment: .bottom) {
        //       HStack {
        //         Button("Random") {
        //           random()
        //           viewStore.send(.parse(arView.scene.anchors.map { $0 }))
        //         }
        //         .buttonStyle(.borderedProminent)
        //         .controlSize(.large)
        //       }
        //       .padding()
        //     }
        //
        //   TextEditor(text: viewStore.binding(\.$dumpOutput))
        //     .monospaced()
        //     .foregroundColor(.cyan)
        //     .multilineTextAlignment(.leading)
        // }
      } detail: {
        Group {
          if let entity = viewStore.selectedEntity {
            EntityDetailView(entity: entity)
          } else {
            Text("Pick an entity")
          }
        }
        .navigationSplitViewColumnWidth(min: 270, ideal: 405, max: 810)
        .navigationSplitViewStyle(.prominentDetail)
      }
      .task {
        random()
        viewStore.send(.parse(arView.scene.anchors.map { $0 }))
      }
    }
  }

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
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(
      store: .init(
        initialState: AppCore.State(),
        reducer: AppCore()
      )
    )
  }
}
