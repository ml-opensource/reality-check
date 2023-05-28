import ComposableArchitecture
import Foundation
import Models
import MultipeerClient
import RealityKit
import StreamingClient

public struct AppCore: Reducer {
  public init() {}

  public struct State: Equatable {
    public var arViewOptions: ARViewOptions.State?
    public var entitiesHierarchy: EntitiesHierarchy.State?
    @BindingState public var isDumpAreaCollapsed: Bool
    public var multipeerConnection: MultipeerConnection.State

    public init(
      arViewOptions: ARViewOptions.State? = nil,
      entitiesHierarchy: EntitiesHierarchy.State? = nil,
      isDumpAreaDisplayed: Bool = true,
      multipeerConnection: MultipeerConnection.State = .init()
    ) {
      self.arViewOptions = arViewOptions
      self.entitiesHierarchy = entitiesHierarchy
      self.isDumpAreaCollapsed = isDumpAreaDisplayed
      self.multipeerConnection = multipeerConnection
    }
  }

  public enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case arViewOptions(ARViewOptions.Action)
    case entitiesHierarchy(EntitiesHierarchy.Action)
    case multipeerConnection(MultipeerConnection.Action)
  }

  @Dependency(\.streamingClient) var streamingClient

  public var body: some Reducer<State, Action> {
    BindingReducer()

    Scope(state: \.multipeerConnection, action: /Action.multipeerConnection) {
      MultipeerConnection()
    }

    Reduce<State, Action> { state, action in
      switch action {
        case .arViewOptions(.delegate(.didUpdateDebugOptions(let options))):
          return .task {
            .multipeerConnection(.sendDebugOptions(options))
          }

        case .arViewOptions(_):
          return .none

        case .binding(_):
          return .none

        case .entitiesHierarchy(_):
          return .none

        case .multipeerConnection(.delegate(.receivedVideoFrameData(let videoFrameData))):
          streamingClient.prepareForRender(videoFrameData)
          return .none

        case .multipeerConnection(.delegate(.receivedDecodedARView(let decodedARView))):
          state.arViewOptions = .init(arView: decodedARView)
          state.entitiesHierarchy = .init(decodedARView.scene.anchors)
          return .none

        case .multipeerConnection(_):
          return .none
      }
    }
    .ifLet(\.arViewOptions, action: /Action.arViewOptions) {
      ARViewOptions()
    }
    .ifLet(\.entitiesHierarchy, action: /Action.entitiesHierarchy) {
      EntitiesHierarchy()
    }
  }
}
