import ComposableArchitecture
import Foundation
import Models
import RealityCodable
import RealityKit
import SwiftUI

@Reducer
public struct ARViewSection {

  @ObservableState
  public struct State: Equatable {
    public var arView: RealityPlatform.iOS.ARView
    public var debugOptions: DebugOptions.State
    public var isDebugOptionsDisplayed: Bool
    public var isSelected: Bool = false

    public init(
      arView: RealityPlatform.iOS.ARView,
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
  }

  public enum DelegateAction: Equatable {
    case didUpdateDebugOptions(_DebugOptions)
  }

  public var body: some Reducer<State, Action> {
    BindingReducer()

    Scope(state: \.debugOptions, action: \.debugOptions) {
      DebugOptions()
    }

    Reduce<State, Action> { state, action in
      switch action {
        case .binding(_):
          return .none

        case .debugOptions(.binding(_)):
          return .send(.delegate(.didUpdateDebugOptions(state.debugOptions.options)))

        case .debugOptions(_):
          return .none

        case .delegate(_):
          return .none
      }
    }
  }
}

@Reducer
public struct DebugOptions {

  @ObservableState
  public struct State: Equatable {
    public var showAnchorGeometry: Bool
    public var showAnchorOrigins: Bool
    public var showFeaturePoints: Bool
    public var showPhysics: Bool
    public var showSceneUnderstanding: Bool
    public var showStatistics: Bool
    public var showWorldOrigin: Bool
    var options: _DebugOptions = .none

    public init(
      _ rawValue: Int
    ) {
      let _debugOptions = _DebugOptions(rawValue: rawValue)
      options = _debugOptions
      showAnchorGeometry = _debugOptions.contains(_DebugOptions.showAnchorGeometry)
      showAnchorOrigins = _debugOptions.contains(_DebugOptions.showAnchorOrigins)
      showFeaturePoints = _debugOptions.contains(.showFeaturePoints)
      showPhysics = _debugOptions.contains(.showPhysics)
      showSceneUnderstanding = _debugOptions.contains(.showSceneUnderstanding)
      showStatistics = _debugOptions.contains(.showStatistics)
      showWorldOrigin = _debugOptions.contains(.showWorldOrigin)
    }
  }

  public enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
  }

  public var body: some Reducer<State, Action> {
    BindingReducer()

    Reduce<State, Action> { state, action in
      switch action {
        case .binding(\.showAnchorGeometry):
          if state.showAnchorGeometry {
            state.options.insert(.showAnchorGeometry)
          } else {
            state.options.remove(.showAnchorGeometry)
          }
          return .none

        case .binding(\.showAnchorOrigins):
          if state.showAnchorOrigins {
            state.options.insert(.showAnchorOrigins)
          } else {
            state.options.remove(.showAnchorOrigins)
          }
          return .none

        case .binding(\.showFeaturePoints):
          if state.showFeaturePoints {
            state.options.insert(.showFeaturePoints)
          } else {
            state.options.remove(.showFeaturePoints)
          }
          return .none

        case .binding(\.showPhysics):
          if state.showPhysics {
            state.options.insert(.showPhysics)
          } else {
            state.options.remove(.showPhysics)
          }
          return .none

        case .binding(\.showSceneUnderstanding):
          if state.showSceneUnderstanding {
            state.options.insert(.showSceneUnderstanding)
          } else {
            state.options.remove(.showSceneUnderstanding)
          }
          return .none

        case .binding(\.showStatistics):
          if state.showStatistics {
            state.options.insert(.showStatistics)
          } else {
            state.options.remove(.showStatistics)
          }
          return .none

        case .binding(\.showWorldOrigin):
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
