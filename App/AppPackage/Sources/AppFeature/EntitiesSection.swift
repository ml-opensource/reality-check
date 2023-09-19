import ComposableArchitecture
import Foundation
import Models

public struct EntitiesSection: Reducer {
  public struct State: Equatable {
    public var identifiedEntities: IdentifiedArrayOf<IdentifiableEntity>

    @BindingState public var dumpOutput: String
    @BindingState public var selection: IdentifiableEntity.ID?

    public var selectedEntity: IdentifiableEntity? {
      guard let selection = selection else { return nil }
      for rootEntity in identifiedEntities {
        if let entity = findIdentifiableEntity(root: rootEntity, targetID: selection) {
          return entity
        }
      }
      return nil
    }

    public init(
      _ identifiedEntities: [IdentifiableEntity],
      selection: IdentifiableEntity.ID? = nil
    ) {
      self.identifiedEntities = .init(uniqueElements: identifiedEntities)
      self.selection = selection ?? self.identifiedEntities.first?.id
      self.dumpOutput = """
        Biscuit dessert tart gummi bears pie biscuit.
        Pastry oat cake fruitcake chocolate cake marzipan shortbread pie toffee muffin.
        Marshmallow biscuit muffin sesame snaps chocolate cake candy tart.
        Tart biscuit croissant tiramisu powder chocolate cake chocolate bar candy canes.
        """
    }
  }

  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case delegate(DelegateAction)
    case dumpOutput(String)
    case refreshEntities([IdentifiableEntity])
  }

  public enum DelegateAction: Equatable {
    case didToggleSelectSection
    case didSelectEntity(IdentifiableEntity.ID)
  }

  public var body: some Reducer<State, Action> {
    BindingReducer()

    Reduce<State, Action> { state, action in
      switch action {
        case .binding(\.$selection):
          if let entity = state.selectedEntity {
            return .merge(
              .send(.delegate(.didToggleSelectSection)),
              .send(.delegate(.didSelectEntity(entity.id)))
            )
          } else {
            return .send(.delegate(.didToggleSelectSection))
          }

        case .binding:
          return .none

        case .delegate(_):
          return .none

        case .dumpOutput(let output):
          state.dumpOutput = output
          return .none

        case .refreshEntities(let entities):
          state.identifiedEntities = .init(uniqueElements: entities)
          guard let previousSelection = state.selection else { return .none }
          state.selection = nil
          return .send(.binding(.set(\.$selection, previousSelection)))
      }
    }
  }
}
