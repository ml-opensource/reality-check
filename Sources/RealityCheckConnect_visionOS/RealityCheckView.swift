import RealityKit
import SwiftUI

public struct RealityCheckView: View {
  @Environment(RealityCheckConnectViewModel.self) private var realityCheckConnectModel

  let make: @MainActor @Sendable (inout RealityViewContent, RealityViewAttachments) async -> Void
  let update: (@MainActor (inout RealityViewContent, RealityViewAttachments) -> Void)?

  public init(
    make: @escaping @MainActor @Sendable (inout RealityViewContent, RealityViewAttachments) async ->
      Void,
    update: (@MainActor (inout RealityViewContent, RealityViewAttachments) -> Void)? = nil
  ) {
    self.make = make
    self.update = update
  }

  public var body: some View {
    RealityView(
      make: { @MainActor content, attachments in
        await make(&content, attachments)
        realityCheckConnectModel.content = content
      },
      update: { @MainActor content, attachments in
        if let indicatorEntity = attachments.entity(for: "Indicator"),
          let selectedEntityID = realityCheckConnectModel.selectedEntityID
        {
          indicatorEntity.name = "RealityCheck Indicator (parent: \(selectedEntityID))"
           content.add(indicatorEntity)

          for entity in content.entities {
            print(">>>", selectedEntityID)
            if entity.id == selectedEntityID {
              //FIXME: Is this relationship not reflected in the hierarchy?
              indicatorEntity.setParent(entity, preservingWorldTransform: false)
              indicatorEntity.setPosition( entity.position, relativeTo: nil)
              //indicatorEntity.look(
              //  at: .zero,
              //  from: content.root!.position,
              //  relativeTo: indicatorEntity.parent
              //)
            }
          }
        }
        update?(&content, attachments)

        if case .connected = realityCheckConnectModel.connectionState {
          Task { [content] in
            await realityCheckConnectModel.sendMultipeerData(content)
          }
        }
      },
      placeholder: {},
      attachments: {
        Text("RealityCheck Indicator")
          .font(.largeTitle)
          .padding(100)
          .glassBackgroundEffect()
          .tag("Indicator")
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
