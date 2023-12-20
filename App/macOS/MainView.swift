import AppFeature
import ComposableArchitecture
import Dependencies
import Models
import MultipeerClient
import StreamingClient
import SwiftUI

struct MainView: View {
  @State var store: StoreOf<AppCore>

  var sessionTitle: String {
    switch store.multipeerConnection.sessionState {
      case .notConnected, .connecting:
        return "RealityCheck"

      case .connected:
        if let connectedPeer = store.multipeerConnection.connectedPeer,
          let appName = connectedPeer.discoveryInfo?.appName
        {
          return appName
        } else {
          return "RealityCheck"
        }
    }
  }

  var sessionSubtitle: String {
    switch store.multipeerConnection.sessionState {
      case .notConnected, .connecting:
        return ""

      case .connected:
        if let discoveryInfo = store.multipeerConnection.connectedPeer?.discoveryInfo,
          let appVersion = discoveryInfo.appVersion,
          let systemIcon = discoveryInfo.systemIcon
        {
          return systemIcon + " \(appVersion)"
        } else {
          return ""
        }
    }
  }

  var body: some View {
    NavigationStack {
      switch store.layout {
        case .double:
          DoubleLayoutView(store: store)

        case .triple:
          TripleLayoutView(store: store)
      }
    }
    .modifier(Inspector(store: store))
    .navigationTitle(sessionTitle)
    .navigationSubtitle(sessionSubtitle)
    .toolbar(id: "Main") {
      MainToolbar(store: store)
    }
  }
}

struct VideoPreviewPaused: View {
  var body: some View {
    HStack {
      Text("Screen capture paused")
        .font(.headline)

      Spacer().frame(maxWidth: 100)
      Button.init(
        "Help",
        systemImage: "questionmark.circle",
        action: {}
      )
      .controlSize(.large)
      .buttonStyle(.plain)
      .labelStyle(.iconOnly)
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 8)
        .fill(Color(nsColor: .controlBackgroundColor))
        .shadow(radius: 1)
    )
  }
}

//FIXME: restore
//struct ContentView_Previews: PreviewProvider {
//  static var previews: some View {
//    MainView(
//      store: .init(
//        initialState: AppCore.State(
//          //FIXME: avoid constructor cleaning mock return
//          arViewSection: ARViewSection.State.init(
//            arView: .init(
//              .init(frame: .zero),
//              anchors: [],
//              contentScaleFactor: 1
//            )
//          ),
//          entitiesSection: .init([], selection: 14_973_088_022_893_562_172)
//        ),
//        reducer: {
//          AppCore()
//            .dependency(\.multipeerClient, .testValue)
//        }
//      )
//    )
//    .navigationSplitViewStyle(.prominentDetail)
//    .frame(width: 500, height: 900)
//  }
//}
