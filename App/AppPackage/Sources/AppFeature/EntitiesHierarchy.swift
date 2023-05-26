import ComposableArchitecture
import Foundation
import Models

public struct EntitiesHierarchy: Reducer {
  public struct State: Equatable {
    public var identifiedEntities: IdentifiedArrayOf<IdentifiableEntity>

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

    public init(
      identifiedEntities: IdentifiedArrayOf<IdentifiableEntity> = [],
      selection: IdentifiableEntity.ID? = nil
    ) {
      self.identifiedEntities = identifiedEntities
      self.selection = selection
    }
  }

  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case identified([IdentifiableEntity])
    case select(entity: IdentifiableEntity?)
  }

  public var body: some Reducer<State, Action> {
    Reduce<State, Action> { state, action in
      switch action {
        case .binding(\.$selection):
          //FIXME:
          return .none
        // return .task { [state] in
        //   // if let entity = state.selectedEntity {
        //   //   return .dumpOutput(String(customDumping: entity))
        //   // } else {
        //   //   return .dumpOutput("...")
        //   // }
        // }

        case .binding:
          return .none

        case .identified(let identifiedEntities):
          state.identifiedEntities = .init(
            uniqueElements: identifiedEntities
          )
          return .task { [state] in
            .set(\.$selection, state.identifiedEntities.first?.id)
          }

        case .select(let entity):
          state.selection = entity?.id
          return .none
      }
    }
  }
}
