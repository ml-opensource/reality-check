import RealityKit
import SwiftUI

public struct RealityCheckView: View {

  @Environment(RealityCheckConnectViewModel.self) var realityCheckConnectModel
  @State private var subscription: EventSubscription?

  let make: @MainActor @Sendable (inout RealityViewContent) async -> Void
  var update: ((inout RealityViewContent) -> Void)?

  public init(
    make: @escaping @MainActor @Sendable (inout RealityViewContent) async -> Void,
    update: ((inout RealityViewContent) -> Void)? = nil
  ) {
    self.make = make
    self.update = update
  }

  public var body: some View {
    RealityView(
      make: { content in
        let referenceEntity = Entity()
        referenceEntity.name = "__realityCheck"
        content.add(referenceEntity)

        subscription = content.subscribe(to: SceneEvents.DidAddEntity.self) { [content] event in
          realityCheckConnectModel.addScene(content)
        }

        subscription = content.subscribe(to: SceneEvents.WillRemoveEntity.self) { [content] event in
          realityCheckConnectModel.removeScene(content)
        }

        await make(&content)
      },
      update: { content in
        realityCheckConnectModel.updateContent(content)
        update?(&content)
      }
    )
  }
}

extension View {
  public func realityCheck() -> some View {
    return
      self
      .background {
        RealityCheckView { _ in }
      }
  }
}
