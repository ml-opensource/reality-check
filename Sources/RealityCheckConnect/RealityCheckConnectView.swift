@_implementationOnly import Dependencies
@_implementationOnly import Models
@_implementationOnly import MultipeerClient
@_implementationOnly import RealityDumpClient
import RealityKit
@_implementationOnly import StreamingClient
import SwiftUI

final class ViewModel: ObservableObject {
  @Published var connectionState: MultipeerClient.SessionState
  @Published var hostName: String
  @Published var isStreaming = false

  @Dependency(\.multipeerClient) var multipeerClient
  @Dependency(\.realityDump) var realityDump
  @Dependency(\.streamingClient) var streamingClient

  fileprivate var arView: ARView?

  init(
    connectionState: MultipeerClient.SessionState = .notConnected,
    hostName: String = "...",
    arView: ARView? = nil
  ) {
    self.connectionState = connectionState
    self.hostName = hostName
    self.arView = arView
  }

  func startMultipeerSession() async {
    //MARK: 1. Setup
    for await action in await multipeerClient.start(
      serviceName: "reality-check",
      sessionType: .peer,
      discoveryInfo: AppInfo.discoveryInfo
    ) {
      switch action {
        case .session(let sessionAction):
          switch sessionAction {
            case .stateDidChange(let state):
              await MainActor.run {
                connectionState = state
              }
              if case .connected = state {
                //MARK: 2. Send Hierarchy
                await sendHierarchy()
              }

            case .didReceiveData(let data):
              //ARView Debug Options
              if let debugOptions = try? JSONDecoder()
                .decode(
                  _DebugOptions.self,
                  from: data
                )
              {
                await MainActor.run {
                  arView?.debugOptions = ARView.DebugOptions(
                    rawValue: debugOptions.rawValue
                  )
                }
              }
          }

        case .browser(_):
          return

        case .advertiser(let advertiserAction):
          switch advertiserAction {
            case .didReceiveInvitationFromPeer(let peer):
              multipeerClient.acceptInvitation()
              multipeerClient.stopAdvertisingPeer()
              await MainActor.run {
                hostName = peer.displayName
              }
          }
      }
    }
  }

  func sendHierarchy() async {
    guard let arView else {
      //FIXME: make a runtime error instead
      fatalError("ARView is required in order to be able to send its hierarchy")
    }

    let encoder = JSONEncoder()
    encoder.nonConformingFloatEncodingStrategy = .convertToString(
      positiveInfinity: "INF",
      negativeInfinity: "-INF",
      nan: "NAN"
    )
    encoder.outputFormatting = .prettyPrinted

    let anchors = await arView.scene.anchors.compactMap { $0 }
    var identifiableAnchors: [IdentifiableEntity] = []
    for anchor in anchors {
      identifiableAnchors.append(
        await realityDump.identify(anchor)
      )
    }

    let arViewData = try! await encoder.encode(
      CodableARView(
        arView,
        anchors: identifiableAnchors,
        contentScaleFactor: arView.contentScaleFactor
      )
    )
    multipeerClient.send(arViewData)
  }

  func startStreaming() async {
    await MainActor.run {
      isStreaming = true
    }

    for await frameData in await streamingClient.startScreenCapture() {
      multipeerClient.send(frameData)
    }
  }

  func stopStreaming() async {
    await MainActor.run {
      isStreaming = false
    }

    streamingClient.stopScreenCapture()
  }
}

/**
Represents a SwiftUI view for controlling the RealityCheck connection and exchange of  the running AR experience data.

Use the `RealityCheckConnectView` struct to display the state of the connection and provide a user interface for establishing a connection with **RealityCheck** macOS app. Once integrated, the GUI will allow to connect and exchange AR scene hierarchy data. It utilizes SwiftUI for rendering the user interface. and can be accessed as a `LibraryItem` from the `Library` panel.

**Usage**

1. Initialize `RealityCheckConnectView` and provide an optional `ARView` instance to enable hierarchy sending functionality.
2. Add `RealityCheckConnectView` to your SwiftUI view hierarchy.

**Example**

Here's an example of how to use `RealityCheckConnectView`:
```swift
var body: some View {
    ZStack {
        // Other views
        RealityCheckConnectView(arView)
    }
}
```
 */
public struct RealityCheckConnectView: View {
  @ObservedObject private var viewModel: ViewModel

  public init() {
    self.viewModel = .init()
  }

  public init(
    _ arView: ARView
  ) {
    self.viewModel = .init(arView: arView)
  }

  fileprivate init(
    viewModel: ViewModel
  ) {
    self.viewModel = viewModel
  }

  var connectionStateFill: Color {
    switch viewModel.connectionState {
      case .notConnected:
        return .red
      case .connecting:
        return .orange
      case .connected:
        return .green
    }
  }

  var connectionStateMessage: String {
    switch viewModel.connectionState {
      case .notConnected:
        return "not connected"
      case .connecting:
        return "connecting"
      case .connected:
        return viewModel.isStreaming
          ? "                "
          : "connected to: \(viewModel.hostName)"
    }
  }

  var isConnected: Bool {
    switch viewModel.connectionState {
      case .notConnected, .connecting:
        return false
      case .connected:
        return true
    }
  }

  @State var location: CGPoint = CGPoint(x: 88, y: 33)
  @GestureState var startLocation: CGPoint? = nil

  public var body: some View {
    RoundedRectangle(cornerRadius: 32, style: .continuous)
      .stroke(lineWidth: viewModel.isStreaming ? 0.5 : 3)
      .fill(Material.ultraThin)
      .animation(.default, value: viewModel.isStreaming)
      .padding()
      .overlay {
        VStack {
          Text(connectionStateMessage)
            .font(.system(.caption, design: .rounded))
            .padding(8)
            .background(
              Capsule(style: .continuous)
                .fill(connectionStateFill)
            )
            .scaleEffect(viewModel.isStreaming ? 0.5 : 1)
            .animation(.default, value: viewModel.isStreaming)

          Spacer()

          GeometryReader { geometry in
            HStack(spacing: 24) {
              Button(
                action: {
                  Task {
                    if viewModel.isStreaming {
                      await viewModel.stopStreaming()
                    } else {
                      await viewModel.startStreaming()
                    }
                  }
                },
                label: {
                  ZStack {
                    Circle().stroke(lineWidth: 3).fill(.primary)

                    RoundedRectangle(
                      cornerRadius: viewModel.isStreaming ? 4 : 20,
                      style: .continuous
                    )
                    .fill(.purple)
                    .padding(viewModel.isStreaming ? 12 : 3)
                    .animation(.easeInOut(duration: 0.15), value: viewModel.isStreaming)
                  }
                }
              )
              .frame(width: 44, height: 44)
              .buttonStyle(.plain)

              Button(
                action: {
                  Task {
                    await viewModel.sendHierarchy()
                  }
                },
                label: {
                  Image(systemName: "arrow.up.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }
              )
              .frame(width: 33, height: 33)
              .buttonStyle(.plain)
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(
              Material.ultraThin,
              in: RoundedRectangle(cornerRadius: 16, style: .continuous)
            )
            .disabled(isConnected ? false : true)
            .position(location)
            .gesture(
              DragGesture()
                .onChanged { value in
                  var newLocation = startLocation ?? location
                  newLocation.x += value.translation.width
                  newLocation.y += value.translation.height
                  location = newLocation
                }
                .updating($startLocation) { value, startLocation, transaction in
                  startLocation = startLocation ?? location
                }
                .onEnded { value in
                  withAnimation(
                    .interpolatingSpring(stiffness: 150, damping: 20, initialVelocity: 5)
                  ) {
                    location = snapToLocation(
                      containerSize: geometry.size,
                      predictedEndLocation: value.predictedEndLocation
                    )
                  }
                }
            )
          }
        }
      }
      .animation(.default, value: viewModel.connectionState)
      .task {
        await viewModel.startMultipeerSession()
      }
  }

  private func snapToLocation(
    containerSize: CGSize,
    predictedEndLocation: CGPoint
  ) -> CGPoint {
    let midWidth = containerSize.width / 2
    let midHeight = containerSize.height / 2
    var endLocation: CGPoint = .zero

    //Top Leading
    if predictedEndLocation.x < midWidth
      && predictedEndLocation.y < midHeight
    {
      endLocation = CGPoint(
        x: 88,
        y: 33
      )
    }
    //Top Trailing
    else if predictedEndLocation.x > midWidth
      && predictedEndLocation.y < midHeight
    {
      endLocation = CGPoint(
        x: containerSize.width - 88,
        y: 33
      )
    }
    //Bottom Leading
    else if predictedEndLocation.x < midWidth
      && predictedEndLocation.y > midHeight
    {
      endLocation = CGPoint(
        x: 88,
        y: containerSize.height - 66
      )
    }
    //Bottom Trailing
    else if predictedEndLocation.x > midWidth
      && predictedEndLocation.y > midHeight
    {
      endLocation = CGPoint(
        x: containerSize.width - 88,
        y: containerSize.height - 66
      )
    }

    return endLocation
  }
}

extension RealityCheckConnectView {
  public func arView(_ arView: ARView) -> Self {
    self.viewModel.arView = arView
    return self
  }
}

#if DEBUG
  struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        RealityCheckConnectView(
          viewModel: withDependencies {
            $0.multipeerClient.start = { (_, _, _, _, _) in
              AsyncStream.finished
            }
          } operation: {
            ViewModel(
              hostName: "MOCKY",
              arView: .init(frame: .null)
            )
          }
        )
        .previewDisplayName(".notConnected")

        RealityCheckConnectView(
          viewModel: withDependencies {
            $0.multipeerClient.start = { (_, _, _, _, _) in
              AsyncStream {
                $0.yield(.session(.stateDidChange(.connecting(Peer(displayName: "MOCKYPEER")))))
              }
            }
          } operation: {
            ViewModel(
              hostName: "MOCKY",
              arView: .init(frame: .null)
            )
          }
        )
        .previewDisplayName(".connecting")

        RealityCheckConnectView(
          viewModel: .init(
            hostName: "MOCKY",
            arView: .init(frame: .null)
          )
        )
        .previewDisplayName(".connected")
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background {
        Image("background_preview", bundle: .module)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .ignoresSafeArea()
      }
      .preferredColorScheme(.light)
    }
  }
#endif
