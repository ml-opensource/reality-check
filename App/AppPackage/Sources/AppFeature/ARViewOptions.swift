import ComposableArchitecture
import Foundation
import Models

public struct ARViewOptions: Reducer {
  public struct State: Equatable {
    public var arView: CodableARView
    @BindingState public var isDebugOptionsDisplayed: Bool = false
  }

  public enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
  }

  public var body: some Reducer<State, Action> {
    BindingReducer()

    Reduce<State, Action> { state, action in
      switch action {
        case .binding(_):
          return .none
      }
    }
  }
}
