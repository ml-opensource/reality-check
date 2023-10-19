import ComposableArchitecture
import CoreGraphics
import Foundation
import Models
import MultipeerClient
import RealityKit
import RealitySymbols
import StreamingClient

public struct AppCore: Reducer {
  public init() {}

  public struct State: Equatable {
    // public var arViewSection: ARViewSection.State?
    public var entitiesSection: EntitiesSection.State?
    @BindingState public var isConsoleCollapsed: Bool
    public var isStreaming: Bool
    public var multipeerConnection: MultipeerConnection.State
    public var selectedSection: Section?
    @BindingState public var viewPortSize: CGSize

    public init(
      // arViewSection: ARViewSection.State? = nil,
      entitiesSection: EntitiesSection.State? = nil,
      displayConsole: Bool = true,
      isStreaming: Bool = false,
      multipeerConnection: MultipeerConnection.State = .init(),
      selectedSection: Section? = nil,
      viewPortSize: CGSize = .zero
    ) {
      // self.arViewSection = arViewSection
      self.entitiesSection = entitiesSection
      self.isConsoleCollapsed = !displayConsole
      self.isStreaming = isStreaming
      self.multipeerConnection = multipeerConnection
      self.selectedSection = selectedSection
      self.viewPortSize = viewPortSize
    }
  }

  public enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    // case arViewSection(ARViewSection.Action)
    case entitiesSection(EntitiesSection.Action)
    case multipeerConnection(MultipeerConnection.Action)
    case selectSection(Section?)
    case updateViewportSize(CGSize)
  }

  public enum Section {
    case arView
    case entities
  }

  @Dependency(\.streamingClient) var streamingClient

  public var body: some Reducer<State, Action> {
    BindingReducer()

    Scope(state: \.multipeerConnection, action: /Action.multipeerConnection) {
      MultipeerConnection()
    }

    Reduce<State, Action> { state, action in
      switch action {
        // case .arViewSection(.delegate(.didToggleSelectSection)):
        //   return .send(.selectSection(state.selectedSection == .arView ? nil : .arView))
        //
        // case .arViewSection(.delegate(.didUpdateDebugOptions(let options))):
        //   return .send(.multipeerConnection(.sendDebugOptions(options)))
        //
        // case .arViewSection(_):
        //   return .none

        case .binding(_):
          return .none

        case .entitiesSection(.delegate(.didToggleSelectSection)):
          return .send(.selectSection((state.entitiesSection?.selection == nil) ? nil : .entities))

        case .entitiesSection(.delegate(.didSelectEntity(let entityID))):
          return .send(.multipeerConnection(.sendSelection(entityID)))

        case .entitiesSection(_):
          return .none

        case .multipeerConnection(.delegate(.receivedVideoFrameData(let videoFrameData))):
          state.isStreaming = true
          streamingClient.prepareForRender(videoFrameData)
          return .none

        case .multipeerConnection(.delegate(.receivedRawData(let rawData))):
          return .send(.entitiesSection(.dumpOutput(rawData)))

        // case .multipeerConnection(.delegate(.receivedDecodedARView(let decodedARView))):
        //   // state.arViewSection = .init(arView: decodedARView)
        //   if state.entitiesSection == nil {
        //     state.entitiesSection = .init(decodedARView.scene.anchors)
        //   }
        //   return .send(.entitiesSection(.refreshEntities(decodedARView.scene.anchors)))

        case .multipeerConnection(.delegate(.receivedDecodedScene(let decodedScene))):
          let entities = decodedScene.children.map(\.value)
          if state.entitiesSection == nil {
            state.entitiesSection = .init(entities)
          }
          return .send(.entitiesSection(.refreshEntities(entities)))

        case .multipeerConnection(.delegate(.receivedDecodedEntities(let decodedEntities))):
          if state.entitiesSection == nil {
            state.entitiesSection = .init(decodedEntities)
          }
          return .send(.entitiesSection(.refreshEntities(decodedEntities)))

        case .multipeerConnection(_):
          return .none

        case .selectSection(let section):
          state.selectedSection = section
          switch section {
            case .none:
              state.entitiesSection?.selection = nil
            // state.arViewSection?.isSelected = false

            case .some(.arView):
              state.entitiesSection?.selection = nil

            case .some(.entities):
              // state.arViewSection?.isSelected = false
              return .none
          }
          return .none

        case .updateViewportSize(let size):
          state.viewPortSize = size
          return .none
      }
    }
    // .ifLet(\.arViewSection, action: /Action.arViewSection) {
    //   ARViewSection()
    // }
    .ifLet(\.entitiesSection, action: /Action.entitiesSection) {
      EntitiesSection()
    }
  }
}
