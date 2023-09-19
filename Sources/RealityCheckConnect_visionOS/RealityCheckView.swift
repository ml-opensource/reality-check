import RealityKit
import SwiftUI

public struct RealityCheckView: View {
  @Environment(RealityCheckConnectViewModel.self)
  var realityCheckConnectModel

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
        referenceEntity.isAccessibilityElement = false
        referenceEntity.isEnabled = false
        content.add(referenceEntity)
        await make(&content)
      },
      update: { content in
        update?(&content)
        realityCheckConnectModel.updateContent(content)
      }
    )
  }
}

extension View {
  public func realityCheck() -> some View {
    self
      .background {
        RealityCheckView { _ in }
      }
  }
}
