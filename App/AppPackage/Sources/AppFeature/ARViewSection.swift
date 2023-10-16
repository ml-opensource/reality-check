import ComposableArchitecture
import Foundation
import Models
import RealityCodable
import RealityKit
import SwiftUI

/* FIXME:
public struct ARViewSection: Reducer {
  public struct State: Equatable {
    public var arView: CodableARView
    public var debugOptions: DebugOptions.State
    @BindingState public var isDebugOptionsDisplayed: Bool
    public var isSelected: Bool = false

    public init(
      arView: CodableARView,
      isDebugOptionsDisplayed: Bool = false,
      isSelected: Bool = false
    ) {
      self.arView = arView
      self.debugOptions = .init(arView.debugOptionsRawValue)
      self.isDebugOptionsDisplayed = isDebugOptionsDisplayed
    }
  }

  public enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case debugOptions(DebugOptions.Action)
    case delegate(DelegateAction)
    case toggleSelection
  }

  public enum DelegateAction: Equatable {
    case didToggleSelectSection
    case didUpdateDebugOptions(_DebugOptions)
  }

  public var body: some Reducer<State, Action> {
    BindingReducer()

    Scope(state: \.debugOptions, action: /Action.debugOptions) {
      DebugOptions()
    }

    Reduce<State, Action> { state, action in
      switch action {
        case .binding(_):
          return .none

        case .debugOptions(.binding(_)):
          return .send(.delegate(.didUpdateDebugOptions(state.debugOptions.options)))
        //          return .task { [state] in
        //            .delegate(.didUpdateDebugOptions(state.debugOptions.options))
        //          }

        case .debugOptions(_):
          return .none

        case .delegate(_):
          return .none

        case .toggleSelection:
          state.isSelected.toggle()
          return .send(.delegate(.didToggleSelectSection))
      //          return .task {
      //            .delegate(.didToggleSelectSection)
      //          }
      }
    }
  }
}
 */

public struct DebugOptions: Reducer {
  public struct State: Equatable {
    @BindingState public var showAnchorGeometry: Bool
    @BindingState public var showAnchorOrigins: Bool
    @BindingState public var showFeaturePoints: Bool
    @BindingState public var showPhysics: Bool
    @BindingState public var showSceneUnderstanding: Bool
    @BindingState public var showStatistics: Bool
    @BindingState public var showWorldOrigin: Bool
    var options: _DebugOptions = .none

    public init(
      _ rawValue: Int
    ) {
      options = _DebugOptions(rawValue: rawValue)
      showAnchorGeometry = options.contains(.showAnchorGeometry)
      showAnchorOrigins = options.contains(.showAnchorOrigins)
      showFeaturePoints = options.contains(.showFeaturePoints)
      showPhysics = options.contains(.showPhysics)
      showSceneUnderstanding = options.contains(.showSceneUnderstanding)
      showStatistics = options.contains(.showStatistics)
      showWorldOrigin = options.contains(.showWorldOrigin)
    }
  }

  public enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
  }

  public var body: some Reducer<State, Action> {
    BindingReducer()

    Reduce<State, Action> { state, action in
      switch action {
        case .binding(\.$showAnchorGeometry):
          if state.showAnchorGeometry {
            state.options.insert(.showAnchorGeometry)
          } else {
            state.options.remove(.showAnchorGeometry)
          }
          return .none

        case .binding(\.$showAnchorOrigins):
          if state.showAnchorOrigins {
            state.options.insert(.showAnchorOrigins)
          } else {
            state.options.remove(.showAnchorOrigins)
          }
          return .none

        case .binding(\.$showFeaturePoints):
          if state.showFeaturePoints {
            state.options.insert(.showFeaturePoints)
          } else {
            state.options.remove(.showFeaturePoints)
          }
          return .none

        case .binding(\.$showPhysics):
          if state.showPhysics {
            state.options.insert(.showPhysics)
          } else {
            state.options.remove(.showPhysics)
          }
          return .none

        case .binding(\.$showSceneUnderstanding):
          if state.showSceneUnderstanding {
            state.options.insert(.showSceneUnderstanding)
          } else {
            state.options.remove(.showSceneUnderstanding)
          }
          return .none

        case .binding(\.$showStatistics):
          if state.showStatistics {
            state.options.insert(.showStatistics)
          } else {
            state.options.remove(.showStatistics)
          }
          return .none

        case .binding(\.$showWorldOrigin):
          if state.showWorldOrigin {
            state.options.insert(.showWorldOrigin)
          } else {
            state.options.remove(.showWorldOrigin)
          }
          return .none

        case .binding(_):
          return .none
      }
    }
  }
}
