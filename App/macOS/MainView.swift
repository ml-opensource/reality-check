import AppFeature
import ComposableArchitecture
import Dependencies
import Models
import StreamingClient
import SwiftUI

struct MainView: View {
  @State private var points: [SIMD3<Float>] = []
  let store: StoreOf<AppCore>

  @State private var isPresented = false

  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      NavigationSplitView {
        Sidebar(viewStore: viewStore)
      } content: {
        ZStack {
          StreamingView()
            .frame(width: 400, height: 800)

          VSplitView {
            Color.clear
            TextEditor(text: .constant(viewStore.dumpOutput))
              .monospaced()
              // .foregroundColor(.cyan)
              .multilineTextAlignment(.leading)
          }
        }
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
      .toolbar {
        ToolbarItem {
          switch viewStore.multipeerConnection.sessionState {
            case .notConnected:
              Button(
                "notConnected",
                action: {}
              )
              .buttonStyle(.plain)
              .foregroundColor(.white)
              .font(.caption)
              .padding(8)
              .background(Capsule(style: .continuous).fill(.red))

            case .connecting:
              Text("connecting")
                .foregroundColor(.white)
                .font(.caption)
                .padding(8)
                .background(Capsule(style: .continuous).fill(.yellow))

            case .connected:
              Text("connected")
                .foregroundColor(.white)
                .font(.caption)
                .padding(8)
                .background(Capsule(style: .continuous).fill(.green))
          }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainView(
      store: .init(
        initialState: AppCore.State(selection: 14_973_088_022_893_562_172),
        reducer: AppCore()
      )
    )
    .navigationSplitViewStyle(.prominentDetail)
  }
}
