import Dependencies
import Models
import MultipeerClient
import MultipeerConnectivity
import RealityDumpClient
import RealityKit
import StreamingClient
import SwiftUI

public struct LibraryViewContent: LibraryContentProvider {

  @LibraryContentBuilder
  public var views: [LibraryItem] {
    LibraryItem(
      RealityCheckConnectView(),
      title: "RealityCheck Connect View",
      category: .control
    )
  }
}

//TODO: allow customization on construction (or via modifiers)
public struct RealityCheckConnectView: View {
  @Dependency(\.multipeerClient) var multipeerClient
  @Dependency(\.realityDump) var realityDump
  @Dependency(\.streamingClient) var streamingClient

  @State private var connectionState: MultipeerClient.SessionState = .notConnected
  @State private var hostName: String = "..."
  @State private var isRecording = false

  private var arView: ARView?

  public init(
    _ arView: ARView? = nil
  ) {
    self.arView = arView
  }

  public var body: some View {
    VStack {
      switch connectionState {
        case .notConnected:
          Text("notConnected")
            .font(.caption)
            .padding(8)
            .background(Capsule(style: .continuous).fill(.red))

          Spacer()

        case .connecting:
          Text("connecting")
            .font(.caption)
            .padding(8)
            .background(Capsule(style: .continuous).fill(.orange))

          Spacer()

        case .connected:
          Text("connected to: \(hostName)")
            .font(.caption)
            .padding(8)
            .background(Capsule(style: .continuous).fill(.green))

          Spacer()

          Button(
            action: {
              //TODO: Toggle start/stop recording at the client level
              isRecording.toggle()

              //MARK: 2. Record
              Task {
                for await frameData in await streamingClient.startScreenCapture() {
                  //MARK: 3. Stream
                  multipeerClient.send(frameData)
                }
              }

              Task {
                let anchors = arView?.scene.anchors.compactMap({ $0 }) ?? []
                
                var identifiableEntities: [IdentifiableEntity] = []
                for anchor in anchors {
                  identifiableEntities.append(
                    //MARK: 4. Parse Hierarchy
                    await realityDump.identify(anchor)
                  )
                }

                //MARK: 4. Encode Hierarchy
                let encoder = JSONEncoder()
                encoder.nonConformingFloatEncodingStrategy = .convertToString(
                  positiveInfinity: "INF",
                  negativeInfinity: "-INF",
                  nan: "NAN"
                )
                encoder.outputFormatting = .prettyPrinted
                let hierarchyData = try! encoder.encode(identifiableEntities)
                 print(String(data: hierarchyData, encoding: .utf8)!)

                //MARK: 4. Send Hierarchy
                multipeerClient.send(hierarchyData)
              }
            },
            label: {
              ZStack {
                Circle().stroke(lineWidth: 4).fill(.white)

                RoundedRectangle(cornerRadius: isRecording ? 8 : 40, style: .continuous)
                  .fill(.purple)
                  .padding(isRecording ? 24 : 6)
                  .animation(.easeInOut(duration: 0.15), value: isRecording)
              }
              .shadow(radius: 3)
            }
          )
          .frame(width: 88, height: 88)
          .buttonStyle(.plain)
      }
    }
    .animation(.default, value: connectionState)
    .task {
      //MARK: 1. Setup
      for await action in await multipeerClient.start(
        serviceName: "reality-check",
        sessionType: .peer
      ) {
        switch action {
          case .session(let sessionAction):
            switch sessionAction {
              case .stateDidChange(let state):
                connectionState = state

              case .didReceiveData(_):
                //TODO:
                break
            }

          case .browser(_):
            return

          case .advertiser(let advertiserAction):
            switch advertiserAction {
              case .didReceiveInvitationFromPeer(let peer):
                multipeerClient.acceptInvitation()
                multipeerClient.stopAdvertisingPeer()
                hostName = peer.displayName
            }
        }
      }
    }
  }
}

#if DEBUG
  struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      RealityCheckConnectView()
    }
  }
#endif
