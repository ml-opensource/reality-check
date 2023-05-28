import ComposableArchitecture
import Foundation
import Models
import MultipeerClient
import RealityKit
import StreamingClient

public struct AppCore: Reducer {
  public init() {}

  public struct State: Equatable {
    public var arViewSection: ARViewSection.State?
    public var entitiesSection: EntitiesSection.State?
    @BindingState public var isDumpAreaCollapsed: Bool
    public var multipeerConnection: MultipeerConnection.State

    public init(
      arViewSection: ARViewSection.State? = nil,
      entitiesSection: EntitiesSection.State? = nil,
      isDumpAreaDisplayed: Bool = true,
      multipeerConnection: MultipeerConnection.State = .init()
    ) {
      self.arViewSection = arViewSection
      self.entitiesSection = entitiesSection
      self.isDumpAreaCollapsed = isDumpAreaDisplayed
      self.multipeerConnection = multipeerConnection
    }
  }

  public enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case arViewSection(ARViewSection.Action)
    case entitiesSection(EntitiesSection.Action)
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
        case .arViewSection(.delegate(.didUpdateDebugOptions(let options))):
          return .task {
            .multipeerConnection(.sendDebugOptions(options))
          }

        case .arViewSection(_):
          return .none

        case .binding(_):
          return .none

        case .entitiesSection(_):
          return .none

        case .multipeerConnection(.delegate(.receivedVideoFrameData(let videoFrameData))):
          streamingClient.prepareForRender(videoFrameData)
          return .none

        case .multipeerConnection(.delegate(.receivedDecodedARView(let decodedARView))):
          state.arViewSection = .init(arView: decodedARView)
          state.entitiesSection = .init(decodedARView.scene.anchors)
          return .none

        case .multipeerConnection(_):
          return .none
      }
    }
    .ifLet(\.arViewSection, action: /Action.arViewSection) {
      ARViewSection()
    }
    .ifLet(\.entitiesSection, action: /Action.entitiesSection) {
      EntitiesSection()
    }
  }
}
