import ComposableArchitecture
import Foundation
import SwiftUI

public struct Inspector: ViewModifier {
  let store: StoreOf<AppCore>

  public init(store: StoreOf<AppCore>) {
    self.store = store
  }

  public func body(content: Content) -> some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      if #available(macOS 14.0, *) {
        content
          .inspector(isPresented: viewStore.$isInspectorDisplayed) {
            IfLetStore(
              self.store.scope(state: \.entitiesNavigator, action: { .entitiesNavigator($0) })
            ) {
              store in
              SwitchStore(store) { state in
                switch state {
                  case .iOS:
                    CaseLet(/EntitiesNavigator.State.iOS, action: EntitiesNavigator.Action.iOS) {
                      store in
                      Inspector_iOS(store)
                    }
                  case .visionOS:
                    CaseLet(
                      /EntitiesNavigator.State.visionOS,
                      action: EntitiesNavigator.Action.visionOS
                    ) {
                      store in
                      Inspector_visionOS(store)
                    }
                }
              }
            }
            .inspectorColumnWidth(min: 277, ideal: 569, max: 811)
            .interactiveDismissDisabled()
          }
      } else {
        //TODO: Fallback on earlier versions
      }
    }
  }
}
