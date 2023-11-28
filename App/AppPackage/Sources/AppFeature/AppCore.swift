import ComposableArchitecture
import CoreGraphics
import Foundation
import Models
import MultipeerClient
import RealityKit
import StreamingClient

public enum Layout {
  case double
  case triple
}

@Reducer
public struct AppCore {
  public init() {}

  @ObservableState
  public struct State: Equatable {
    public var entitiesNavigator: EntitiesNavigator.State?
    public var isConnectionSetupPresented: Bool
    public var isConsoleDetached: Bool
    public var isConsolePresented: Bool
    public var isInspectorDisplayed: Bool
    public var isStreaming: Bool
    public var layout: Layout
    public var multipeerConnection: MultipeerConnection.State
    public var selectedSection: Section
    public var viewPortSize: CGSize

    public init(
      entitiesNavigator: EntitiesNavigator.State? = nil,
      isConnectionSetupPresented: Bool = true,
      isConsoleDetached: Bool = false,
      isConsolePresented: Bool = false,
      isInspectorDisplayed: Bool = false,
      isStreaming: Bool = false,
      layout: Layout = .double,
      multipeerConnection: MultipeerConnection.State = .init(),
      selectedSection: Section = .entities,
      viewPortSize: CGSize = .zero
    ) {
      self.entitiesNavigator = entitiesNavigator
      self.isConnectionSetupPresented = isConnectionSetupPresented
      self.isConsoleDetached = isConsoleDetached
      self.isConsolePresented = isConsolePresented
      self.isInspectorDisplayed = isInspectorDisplayed
      self.isStreaming = isStreaming
      self.layout = layout
      self.multipeerConnection = multipeerConnection
      self.selectedSection = selectedSection
      self.viewPortSize = viewPortSize
    }
  }

  @CasePathable
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case entitiesNavigator(EntitiesNavigator.Action)
    case multipeerConnection(MultipeerConnection.Action)
    case updateViewportSize(CGSize)
  }

  public enum Section {
    case arView
    case entities
  }

  @Dependency(\.streamingClient) var streamingClient

  public var body: some ReducerOf<Self> {
    BindingReducer()

    Scope(state: \.multipeerConnection, action: \.multipeerConnection) {
      MultipeerConnection()
    }

    Reduce<State, Action> { state, action in
      switch action {
        case .binding(_):
          return .none

        case .entitiesNavigator(
          .iOS(.arViewSection(.delegate(.didUpdateDebugOptions(let options))))
        ):
          return .send(.multipeerConnection(.sendDebugOptions(options)))

        case .entitiesNavigator(.iOS(.delegate(.didSelectEntity(let entityID)))),
          .entitiesNavigator(.visionOS(.delegate(.didSelectEntity(let entityID)))):
          return .send(.multipeerConnection(.sendSelection(entityID)))

        case .entitiesNavigator:
          return .none

        case .multipeerConnection(.delegate(.receivedVideoFrameData(let videoFrameData))):
          state.isStreaming = true
          streamingClient.prepareForRender(videoFrameData)
          return .none

        case .multipeerConnection(.delegate(.receivedDump(let dump))):
          switch state.entitiesNavigator {
            case .some(.iOS):
              return .send(.entitiesNavigator(.iOS(.dumpOutput(dump))))
            case .some(.visionOS):
              return .send(.entitiesNavigator(.visionOS(.dumpOutput(dump))))
            case .none:
              return .none
          }

        case .multipeerConnection(.delegate(.receivedDecodedARView(let decodedARView))):
          let entities = decodedARView.scene.anchors.map(\.value)
          if state.entitiesNavigator == nil {
            state.entitiesNavigator = .iOS(
              //FIXME: This now looks very complicated. Simplify.
              .init(entities, arViewSection: .init(arView: decodedARView))
            )
          }
          state.isInspectorDisplayed = true
          return .send(.entitiesNavigator(.iOS(.refreshEntities(entities))))

        case .multipeerConnection(.delegate(.receivedDecodedScene(let decodedScene))):
          let entities = decodedScene.children.map(\.value)
          if state.entitiesNavigator == nil {
            state.entitiesNavigator = .visionOS(.init(entities))
          }
          state.isInspectorDisplayed = true
          return .send(.entitiesNavigator(.visionOS(.refreshEntities(entities))))

        case .multipeerConnection(.delegate(.peersUpdated)):
          /// Display "Connection Setup" dialog when not connected to any peer but theres at least one available
          if !state.multipeerConnection.peers.isEmpty,
            state.multipeerConnection.sessionState == .notConnected
          {
            state.isConnectionSetupPresented = true
          }
          return .none

        case .multipeerConnection(_):
          return .none

        case .updateViewportSize(let size):
          state.viewPortSize = size
          return .none
      }
    }
    .ifLet(\.entitiesNavigator, action: \.entitiesNavigator) {
      EntitiesNavigator()
    }
  }
}
