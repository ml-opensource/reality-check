import ComposableArchitecture
import Foundation
import MessagePack
import Models
import MultipeerClient
import RealityDumpClient
import RealityKit
import StreamingClient

public struct AppCore: Reducer {
  public init() {}

  public struct State: Equatable {
    public var identifiedEntities: IdentifiedArrayOf<IdentifiableEntity>
    public var multipeerConnection: MultipeerConnection.State
    @BindingState public var selection: IdentifiableEntity.ID?
    public var selectedEntity: IdentifiableEntity? {
      guard let selection = selection else { return nil }
      for rootEntity in identifiedEntities {
        if let entity = findEntity(root: rootEntity, targetID: selection) {
          return entity
        }
      }
      return nil
    }
    @BindingState public var dumpOutput: String

    public init(
      identifiedEntities: IdentifiedArrayOf<IdentifiableEntity> = [],
      multipeerConnection: MultipeerConnection.State = .init(),
      selection: IdentifiableEntity.ID? = nil,
      dumpOutput: String = """
        Biscuit dessert tart gummi bears pie biscuit.
        Pastry oat cake fruitcake chocolate cake marzipan shortbread pie toffee muffin.
        Marshmallow biscuit muffin sesame snaps chocolate cake candy tart.
        Tart biscuit croissant tiramisu powder chocolate cake chocolate bar candy canes.
        """
    ) {
      self.identifiedEntities = identifiedEntities
      self.multipeerConnection = multipeerConnection
      self.selection = selection
      self.dumpOutput = dumpOutput
    }
  }

  public enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case entitiesIdentified([IdentifiableEntity])
    case multipeerConnection(MultipeerConnection.Action)
    case parse([RealityKit.Entity])
    case dumpOutput(String)
    case select(entity: IdentifiableEntity?)
  }

  @Dependency(\.realityDump) var realityDump
  @Dependency(\.streamingClient) var streamingClient

  public var body: some Reducer<State, Action> {
    BindingReducer()

    Scope(state: \.multipeerConnection, action: /Action.multipeerConnection) {
      MultipeerConnection()
    }

    Reduce<State, Action> { state, action in
      switch action {
        case .binding(\.$selection):
          return .task { [state] in
            if let entity = state.selectedEntity {
              return .dumpOutput(String(customDumping: entity))
            } else {
              return .dumpOutput("...")
            }
          }

        case .binding:
          return .none

        case .entitiesIdentified(let identifiableEntities):
          state.identifiedEntities = .init(
            uniqueElements: identifiableEntities
          )
          return .task { [state] in
            .set(\.$selection, state.identifiedEntities.first?.id)
          }

        case .multipeerConnection(.delegate(.receivedVideoFrameData(let videoFrameData))):
          streamingClient.prepareForRender(videoFrameData)
          return .none

        case .multipeerConnection(
          .delegate(.receivedVideoHierarchyData(let identifiableEntities))
        ):
          return .task {
            .entitiesIdentified(identifiableEntities)
          }

        //case .multipeerConnection(.delegate(.didUpdateSessionState(let connectionState))):
        //  if connectionState == .notConnected {
        //    state.selection = nil
        //    state.identifiedEntities.removeAll()
        //  }
        //  return .none

        case .multipeerConnection(_):
          return .none

        case .parse(let entities):
          return .task {
            var identifiableEntities: [IdentifiableEntity] = []
            for entity in entities {
              identifiableEntities.append(
                await realityDump.identify(entity)
              )
            }
            return .entitiesIdentified(identifiableEntities)
          }

        case .dumpOutput(let output):
          state.dumpOutput = output
          return .none

        case .select(let entity):
          state.selection = entity?.id
          return .none
      }
    }
  }
}
