import ComposableArchitecture
import Foundation
import SwiftUI

@Reducer public struct EntitiesNavigator {
  public enum State: Equatable {
    case iOS(EntitiesNavigator_iOS.State)
    //TODO: case macOS(EntitiesNavigator_macOS.State)
    case visionOS(EntitiesNavigator_visionOS.State)

    public var dumpOutput: String {
      switch self {
        case .iOS(let state):
          return state.dumpOutput

        case .visionOS(let state):
          return state.dumpOutput
      }
    }
  }

  public enum Action: Equatable {
    case iOS(EntitiesNavigator_iOS.Action)
    case visionOS(EntitiesNavigator_visionOS.Action)
  }

  public var body: some ReducerOf<Self> {
    Scope(state: \.iOS, action: \.iOS) {
      EntitiesNavigator_iOS()
    }
    Scope(state: \.visionOS, action: \.visionOS) {
      EntitiesNavigator_visionOS()
    }
  }
}
///https://github.com/pointfreeco/swift-composable-architecture/blob/63ed79606882de385e22afcdf847e46277142b07/Sources/ComposableArchitecture/Macros.swift#L80
///
///
/// There is currently a bug in the Swift compiler and macros that prevents you from extending
/// types that are inside other types with macros applied in the same file. For example, if you
/// wanted to extend a reducer's `State` with some extra functionality:
///
/// ```swift
/// @Reducer
/// struct Feature {
///   struct State { /* ... */ }
///   // ...
/// }
///
/// extension Feature.State {  // 🛑 Circular reference
///   // ...
/// }
/// ```
///
/// This unfortunately does not work. It is a
/// [known issue](https://github.com/apple/swift/issues/66450), and the only workaround is to
/// either move the extension to a separate file, or move the code from the extension to be
/// directly inside the `State` type.
///

/// ```
/// extension EntitiesNavigator.State {
///   public var dumpOutput: String {
///     switch self {
///       case .iOS(let state):
///         return state.dumpOutput
///
///       case .visionOS(let state):
///         return state.dumpOutput
///     }
///   }
/// }
/// ```

public struct NavigatorView: View {
  let store: StoreOf<AppCore>

  public init(store: StoreOf<AppCore>) {
    self.store = store
  }

  public var body: some View {
    IfLetStore(self.store.scope(state: \.entitiesNavigator, action: { .entitiesNavigator($0) })) {
      store in
      SwitchStore(store) { state in
        switch state {
          case .iOS:
            CaseLet(\EntitiesNavigator.State.iOS, action: EntitiesNavigator.Action.iOS) { store in
              EntitiesNavigatorView_iOS(store: store)
            }
          case .visionOS:
            CaseLet(/EntitiesNavigator.State.visionOS, action: EntitiesNavigator.Action.visionOS) {
              store in
              EntitiesNavigatorView_visionOS(store: store)
            }
        }
      }
    } else: {
      ContentUnavailableView(
        "No Entities",
        systemImage: "move.3d",
        description: Text("Connect to an inspectable app to examine its hierarchy")
      )
    }
  }
}
