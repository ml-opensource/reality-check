import ComposableArchitecture
import Foundation
import Models
import MultipeerClient
import RealityDumpClient
import RealityKit
import StreamingClient

public struct AppCore: Reducer {
  public init() {}

  public struct State: Equatable {
    public var entitiesHierarchy: EntitiesHierarchy.State
    public var multipeerConnection: MultipeerConnection.State
    @BindingState public var dumpOutput: String

    public init(
      entitiesHierarchy: EntitiesHierarchy.State = .init(),
      multipeerConnection: MultipeerConnection.State = .init(),
      dumpOutput: String = """
        Biscuit dessert tart gummi bears pie biscuit.
        Pastry oat cake fruitcake chocolate cake marzipan shortbread pie toffee muffin.
        Marshmallow biscuit muffin sesame snaps chocolate cake candy tart.
        Tart biscuit croissant tiramisu powder chocolate cake chocolate bar candy canes.
        """
    ) {
      self.entitiesHierarchy = entitiesHierarchy
      self.multipeerConnection = multipeerConnection
      self.dumpOutput = dumpOutput
    }
  }

  public enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case entitiesHierarchy(EntitiesHierarchy.Action)
    case multipeerConnection(MultipeerConnection.Action)
    case dumpOutput(String)
  }

  @Dependency(\.realityDump) var realityDump
  @Dependency(\.streamingClient) var streamingClient

  public var body: some Reducer<State, Action> {
    BindingReducer()

    Scope(state: \.entitiesHierarchy, action: /Action.entitiesHierarchy) {
      EntitiesHierarchy()
    }

    Scope(state: \.multipeerConnection, action: /Action.multipeerConnection) {
      MultipeerConnection()
    }

    Reduce<State, Action> { state, action in
      switch action {
        case .binding:
          return .none

        case .entitiesHierarchy(_):
          return .none

        case .multipeerConnection(.delegate(.receivedVideoFrameData(let videoFrameData))):
          streamingClient.prepareForRender(videoFrameData)
          return .none

        case .multipeerConnection(
          .delegate(.receivedDecodedARView(let decodedARView))
        ):
          return .task {
            .entitiesHierarchy(.identified(decodedARView.scene.anchors))
          }

        case .multipeerConnection(_):
          return .none

        case .dumpOutput(let output):
          state.dumpOutput = output
          return .none
      }
    }
  }
}
