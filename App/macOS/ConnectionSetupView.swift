import AppFeature
import ComposableArchitecture
import SwiftUI

struct ConnectionSetupView: View {
  let store: StoreOf<MultipeerConnection>

  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      List(viewStore.peers) { peer in
        Button(
          action: {
            viewStore.send(.invite(peer))
          },
          label: {
            Label(
              title: { Text(peer.displayName) },
              icon: { Image(systemName: "phone") }
            )
          }
        )
        .padding(2)
        .buttonStyle(.bordered)
        .controlSize(.large)
      }
      .frame(width: 400, height: 500)
      .animation(.easeInOut, value: viewStore.peers)
      .task {
        viewStore.send(.start)
      }
    }
  }
}

struct ConnectionSetupView_Previews: PreviewProvider {
  static var previews: some View {
    ConnectionSetupView(
      store: Store(
        initialState: AppCore.State(
          multipeerConnection: .init(
            peers: [
              .init(displayName: "Manolo")
            ]
          )
        ),
        reducer: AppCore()
      )
      .scope(
        state: \.multipeerConnection,
        action: AppCore.Action.multipeerConnection
      )
    )
  }
}
