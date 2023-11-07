import ComposableArchitecture
import Foundation

struct EntitiesNavigator: Reducer {
  enum Platform: Equatable {
    case iOS(EntitiesNavigator_iOS.State)
    //TODO: case macOS(EntitiesNavigator_macOS.State)
    case visionOS(EntitiesNavigator_visionOS.State)
  }

  struct State: Equatable {
    var entitiesSection: Platform?
  }

  enum Action: Equatable {
  }

  var body: some Reducer<State, Action> {
    Reduce<State, Action> { state, action in
      return .none
    }
  }
}
