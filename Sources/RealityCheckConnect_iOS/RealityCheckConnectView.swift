import Dependencies
import MultipeerClient
import RealityKit
import SwiftUI

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
                      await viewModel.stopVideoStreaming()
                    } else {
                      await viewModel.startVideoStreaming()
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
                    await viewModel.sendMultipeerData()
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
  }
}

extension RealityCheckConnectView {
  public func arView(_ arView: ARView) -> Self {
    self.viewModel.arView = arView
    return self
  }
}

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
