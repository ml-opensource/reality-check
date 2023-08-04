import RealityKit
import SwiftUI

public struct RealityCheckConnectView: View {
  private var viewModel: RealityCheckConnectViewModel

  public init(
    _ viewModel: RealityCheckConnectViewModel
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

  public var body: some View {
    RealityView(
      viewModel,
      make: { content in
        let reference = ModelEntity(mesh: .generateSphere(radius: 0.001))
        reference.name = "RealityCheckConnectViewReference"
        content.add(reference)
      },
      update: { content in

      }
    )
  }
  // public var body: some View {
  //   RealityView(
  //     make: { content in
  //       let reference = ModelEntity(mesh: .generateSphere(radius: 0.001))
  //       reference.name = "RealityCheckConnectViewReference"
  //       content.add(reference)
  //       await viewModel.sendHierarchy(content: content)
  //     },
  //     update: { content in
  //       //TODO: update
  //       // viewModel.content = content
  //       // await viewModel.sendHierarchy()
  //     }
  //   )
  //   // .task {
  //   //     await viewModel.sendHierarchy(content: <#T##RealityViewContent#>)
  //   // }
  // }
}
