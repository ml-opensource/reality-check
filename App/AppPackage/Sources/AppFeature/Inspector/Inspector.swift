import ComposableArchitecture
import Foundation
import SwiftUI

public struct Inspector: ViewModifier {
  @State var store: StoreOf<AppCore>

  public init(store: StoreOf<AppCore>) {
    self.store = store
  }

  public func body(content: Content) -> some View {
    content
      .inspector(isPresented: $store.isInspectorDisplayed) {
        Group {
          if let childStore = store.scope(state: \.entitiesNavigator, action: \.entitiesNavigator) {
            switch childStore.state {
              case .iOS:
                if let store = childStore.scope(state: \.iOS, action: \.iOS) {
                  Inspector_iOS(store: store)
                }
              case .visionOS:
                if let store = childStore.scope(state: \.visionOS, action: \.visionOS) {
                  Inspector_visionOS(store: store)
                }
            }
          }
        }
        .inspectorColumnWidth(min: 277, ideal: 569, max: 811)
        .interactiveDismissDisabled()
        .accessibilityLabel("Inspector group")
      }
  }
}
