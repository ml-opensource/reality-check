import ComposableArchitecture
import Foundation
import Models
import MultipeerClient
import RealityKit
import StreamingClient

public struct AppCore: Reducer {
  public init() {}

  public struct State: Equatable {
    public var entitiesHierarchy: EntitiesHierarchy.State
    public var multipeerConnection: MultipeerConnection.State

    public init(
      entitiesHierarchy: EntitiesHierarchy.State = .init(),
      multipeerConnection: MultipeerConnection.State = .init()
    ) {
      self.entitiesHierarchy = entitiesHierarchy
      self.multipeerConnection = multipeerConnection
    }
  }

  public enum Action: Equatable {
    case entitiesHierarchy(EntitiesHierarchy.Action)
    case multipeerConnection(MultipeerConnection.Action)
  }

  @Dependency(\.streamingClient) var streamingClient

  public var body: some Reducer<State, Action> {
    Scope(state: \.entitiesHierarchy, action: /Action.entitiesHierarchy) {
      EntitiesHierarchy()
    }

    Scope(state: \.multipeerConnection, action: /Action.multipeerConnection) {
      MultipeerConnection()
    }

    Reduce<State, Action> { state, action in
      switch action {
        case .entitiesHierarchy(_):
          return .none

        case .multipeerConnection(.delegate(.receivedVideoFrameData(let videoFrameData))):
          streamingClient.prepareForRender(videoFrameData)
          return .none

        case .multipeerConnection(.delegate(.receivedDecodedARView(let decodedARView))):
          return .task {
            .entitiesHierarchy(.identified(decodedARView.scene.anchors))
          }

        case .multipeerConnection(_):
          return .none
      }
    }
  }
}
