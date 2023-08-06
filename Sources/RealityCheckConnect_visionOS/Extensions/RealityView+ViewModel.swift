import RealityKit
import SwiftUI

/*
//TODO: This would be significantly more pleasant.
 extension RealityView {
  public init(
    _ realityCheckConnectViewModel: RealityCheckConnectViewModel,
    make: @escaping @MainActor @Sendable (inout RealityViewContent) async -> Void,
    update: (@MainActor (inout RealityViewContent) -> Void)? = nil
  ) where Content == RealityViewContent.Body<RealityViewDefaultPlaceholder> {
    self.init(
      make: { @MainActor content in
        await make(&content)
        realityCheckConnectViewModel.content = content
      },
      update: { @MainActor content in
        update?(&content)
        if case .connected = realityCheckConnectViewModel.connectionState {
          Task { [content] in
            await realityCheckConnectViewModel.sendMultipeerData(content)
          }
        }
      }
    )
  }
}
*/
