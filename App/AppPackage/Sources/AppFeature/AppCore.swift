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

public struct AppCore: Reducer {
  public init() {}

  public struct State: Equatable {
    // public var arViewSection: ARViewSection.State?
    public var entitiesSection: EntitiesNavigator_visionOS.State?
    @BindingState public var isConnectionSetupPresented: Bool
    @BindingState public var isConsoleDetached: Bool
    @BindingState public var isConsolePresented: Bool
    @BindingState public var isInspectorDisplayed: Bool
    public var isStreaming: Bool
    @BindingState public var layout: Layout
    public var multipeerConnection: MultipeerConnection.State
    public var selectedSection: Section
    @BindingState public var viewPortSize: CGSize

    public init(
      // arViewSection: ARViewSection.State? = nil,
      entitiesSection: EntitiesNavigator_visionOS.State? = nil,
      isConnectionSetupPresented: Bool = true,
      isConsoleDetached: Bool = false,
      isConsolePresented: Bool = false,
      isInspectorDisplayed: Bool = false,
      isStreaming: Bool = false,
      layout: Layout = .triple,
      multipeerConnection: MultipeerConnection.State = .init(),
      selectedSection: Section = .entities,
      viewPortSize: CGSize = .zero
    ) {
      // self.arViewSection = arViewSection
      self.entitiesSection = entitiesSection
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

  public enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    // case arViewSection(ARViewSection.Action)
    case entitiesNavigator(EntitiesNavigator_visionOS.Action)
    case multipeerConnection(MultipeerConnection.Action)
    case selectSection(Section)
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

        case .entitiesNavigator(.delegate(.didToggleSelectSection)):
          state.isInspectorDisplayed = (state.entitiesSection?.selection != nil)
          return .send(.selectSection(.entities))

        case .entitiesNavigator(.delegate(.didSelectEntity(let entityID))):
          return .send(.multipeerConnection(.sendSelection(entityID)))

        case .entitiesNavigator(_):
          return .none

        case .multipeerConnection(.delegate(.receivedVideoFrameData(let videoFrameData))):
          state.isStreaming = true
          streamingClient.prepareForRender(videoFrameData)
          return .none

        case .multipeerConnection(.delegate(.receivedRawData(let rawData))):
          return .send(.entitiesNavigator(.dumpOutput(rawData)))

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
          return .send(.entitiesNavigator(.refreshEntities(entities)))

        case .multipeerConnection(.delegate(.receivedDecodedEntities(let decodedEntities))):
          if state.entitiesSection == nil {
            state.entitiesSection = .init(decodedEntities)
          }
          return .send(.entitiesNavigator(.refreshEntities(decodedEntities)))

        case .multipeerConnection(.delegate(.peersUpdated)):
          /// Display Connection Setup dialog when not connected to any peer but theres at least one available
          if !state.multipeerConnection.peers.isEmpty,
            state.multipeerConnection.sessionState == .notConnected
          {
            state.isConnectionSetupPresented = true
          }
          return .none

        case .multipeerConnection(_):
          return .none

        case .selectSection(let section):
          state.selectedSection = section
          switch section {
            case .arView:
              state.entitiesSection?.selection = nil

            case .entities:
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
    .ifLet(\.entitiesSection, action: /Action.entitiesNavigator) {
      EntitiesNavigator_visionOS()
    }
  }
}
