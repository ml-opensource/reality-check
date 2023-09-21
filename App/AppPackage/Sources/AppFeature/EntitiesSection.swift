import ComposableArchitecture
import Foundation
import RealityCodable

public struct EntitiesSection: Reducer {
  public struct State: Equatable {
    public var identifiedEntities: IdentifiedArrayOf<_CodableEntity>

    @BindingState public var dumpOutput: String
    @BindingState public var selection: _CodableEntity.ID?

    public var selectedEntity: _CodableEntity? {
      guard let selection = selection else { return nil }
      for rootEntity in identifiedEntities {
        if let entity = findCodableEntity(root: rootEntity, targetID: selection) {
          return entity
        }
      }
      return nil
    }

    public init(
      _ identifiedEntities: [_CodableEntity],
      selection: _CodableEntity.ID? = nil
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
    case refreshEntities([_CodableEntity])
  }

  public enum DelegateAction: Equatable {
    case didToggleSelectSection
    case didSelectEntity(_CodableEntity.ID)
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
