import ComposableArchitecture
import Foundation
import Models
import RealityKit
import SwiftUI

public struct ARViewOptions: Reducer {
  public struct State: Equatable {
    public var arView: CodableARView
    var debugOptions: DebugOptions.State
    @BindingState public var isDebugOptionsDisplayed: Bool

    init(
      arView: CodableARView,
      isDebugOptionsDisplayed: Bool = false
    ) {
      self.arView = arView
      self.debugOptions = .init(arView.debugOptionsRawValue)
      self.isDebugOptionsDisplayed = isDebugOptionsDisplayed
    }
  }

  public enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case debugOptions(DebugOptions.Action)
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

        case .debugOptions(_):
          return .none
      }
    }
  }
}

public struct DebugOptions: Reducer {
  //Needed because macOS doesn't have all the values available.
  struct _DebugOptions: OptionSet {
    let rawValue: Int

    static let none = _DebugOptions(rawValue: 0)
    static let showAnchorGeometry = _DebugOptions(rawValue: 1 << 4)  // 16
    static let showAnchorOrigins = _DebugOptions(rawValue: 1 << 3)  // 8
    static let showFeaturePoints = _DebugOptions(rawValue: 1 << 5)  // 32
    static let showPhysics = _DebugOptions(rawValue: 1 << 0)  // 1
    static let showSceneUnderstanding = _DebugOptions(rawValue: 1 << 6)  // 64
    static let showStatistics = _DebugOptions(rawValue: 1 << 1)  // 2
    static let showWorldOrigin = _DebugOptions(rawValue: 1 << 2)  // 4
  }

  public struct State: Equatable {
    @BindingState var showAnchorGeometry: Bool
    @BindingState var showAnchorOrigins: Bool
    @BindingState var showFeaturePoints: Bool
    @BindingState var showPhysics: Bool
    @BindingState var showSceneUnderstanding: Bool
    @BindingState var showStatistics: Bool
    @BindingState var showWorldOrigin: Bool
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

//MARK: - View

public struct ARViewOptionsView: View {
  let store: StoreOf<ARViewOptions>

  public init(
    store: StoreOf<ARViewOptions>
  ) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(
      self.store.scope(
        state: \.debugOptions,
        action: ARViewOptions.Action.debugOptions
      ),
      observe: { $0 }
    ) { viewStore in
      Form {
        Toggle("Anchor Geometry", isOn: viewStore.binding(\.$showAnchorGeometry))
        Toggle("Anchor Origins", isOn: viewStore.binding(\.$showAnchorOrigins))
        Toggle("Feature Points", isOn: viewStore.binding(\.$showFeaturePoints))
        Toggle("Physics", isOn: viewStore.binding(\.$showPhysics))
        Toggle(
          "Scene Reconstruction",
          isOn: viewStore.binding(\.$showSceneUnderstanding)
        )
        //.disabled(!ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh))
        Toggle("Statistics", isOn: viewStore.binding(\.$showStatistics))
        Toggle("World Origin", isOn: viewStore.binding(\.$showWorldOrigin))
      }
    }
  }
}
