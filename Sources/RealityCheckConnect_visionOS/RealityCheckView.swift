import RealityKit
import SwiftUI

public struct RealityCheckView: View {
  let realityCheckConnectViewModel: RealityCheckConnectViewModel
  let make: @MainActor @Sendable (inout RealityViewContent, RealityViewAttachments) async -> Void
  let update: (@MainActor (inout RealityViewContent, RealityViewAttachments) -> Void)?

  public init(
    _ realityCheckConnectViewModel: RealityCheckConnectViewModel,
    make: @escaping @MainActor @Sendable (inout RealityViewContent, RealityViewAttachments) async ->
      Void,
    update: (@MainActor (inout RealityViewContent, RealityViewAttachments) -> Void)? = nil
  ) {
    self.realityCheckConnectViewModel = realityCheckConnectViewModel
    self.make = make
    self.update = update
  }

  public var body: some View {
    RealityView(
      make: { @MainActor content, attachments in
        await make(&content, attachments)
        realityCheckConnectViewModel.content = content
      },
      update: { @MainActor content, attachments in
        if let indicatorEntity = attachments.entity(for: "INDICATOR") {
          indicatorEntity.name = "Le Indicator"
          content.add(indicatorEntity)
          indicatorEntity.look(
            at: .zero,
            from: content.root!.position,
            relativeTo: indicatorEntity.parent
          )
          indicatorEntity.move(to: content.root!.transform, relativeTo: nil)
        }
        update?(&content, attachments)

        if case .connected = realityCheckConnectViewModel.connectionState {
          Task { [content] in
            await realityCheckConnectViewModel.sendMultipeerData(content)
          }
        }
      },
      placeholder: {},
      attachments: {
        Text("INDICATOR")
          .font(.largeTitle)
          .padding(100)
          .glassBackgroundEffect()
          .tag("INDICATOR")
      }
    )
  }
}

//public struct RealityCheckConnectView: View {
//  private var viewModel: RealityCheckConnectViewModel
//
//  public init(
//    _ viewModel: RealityCheckConnectViewModel
//  ) {
//    self.viewModel = viewModel
//  }
//
//  var connectionStateFill: Color {
//    switch viewModel.connectionState {
//      case .notConnected:
//        return .red
//      case .connecting:
//        return .orange
//      case .connected:
//        return .green
//    }
//  }
//
//  var connectionStateMessage: String {
//    switch viewModel.connectionState {
//      case .notConnected:
//        return "not connected"
//      case .connecting:
//        return "connecting"
//      case .connected:
//        return viewModel.isStreaming
//          ? "                "
//          : "connected to: \(viewModel.hostName)"
//    }
//  }
//
//  var isConnected: Bool {
//    switch viewModel.connectionState {
//      case .notConnected, .connecting:
//        return false
//      case .connected:
//        return true
//    }
//  }
//
//  public var body: some View {
//    RealityView(viewModel) { content in
//      let reference = ModelEntity(mesh: .generateSphere(radius: 0.001))
//      reference.name = "RealityCheckConnectViewReference"
//      content.add(reference)
//    }
//  }
//}
