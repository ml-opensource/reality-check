import ComposableArchitecture
import Foundation

public struct EntitiesNavigator: Reducer {
  public enum State: Equatable {
    case iOS(EntitiesNavigator_iOS.State)
    //TODO: case macOS(EntitiesNavigator_macOS.State)
    case visionOS(EntitiesNavigator_visionOS.State)
  }

  public enum Action: Equatable {
    case iOS(EntitiesNavigator_iOS.Action)
    case visionOS(EntitiesNavigator_visionOS.Action)
  }

  public var body: some ReducerOf<Self> {
    Scope(state: /State.iOS, action: /Action.iOS) {
      EntitiesNavigator_iOS()
    }
    Scope(state: /State.visionOS, action: /Action.visionOS) {
      EntitiesNavigator_visionOS()
    }
  }
}

extension EntitiesNavigator.State {
  public var dumpOutput: String {
    switch self {
      case .iOS(let state):
        return state.dumpOutput

      case .visionOS(let state):
        return state.dumpOutput
    }
  }
}
