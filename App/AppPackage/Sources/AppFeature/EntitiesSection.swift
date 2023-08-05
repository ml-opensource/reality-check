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
        if let entity = findEntity(root: rootEntity, targetID: selection) {
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
    case select(entity: IdentifiableEntity?)
  }

  public enum DelegateAction: Equatable {
    case didToggleSelectSection
  }

  @Dependency(\.continuousClock) var clock

  public var body: some Reducer<State, Action> {
    BindingReducer()

    Reduce<State, Action> { state, action in
      switch action {
        case .binding(\.$selection):
          if let entity = state.selectedEntity {
            return .merge(
              .send(.dumpOutput(String(customDumping: entity))),
              .send(.delegate(.didToggleSelectSection))
            )
          } else {
            return .merge(
              .send(.dumpOutput("...")),
              .send(.delegate(.didToggleSelectSection))
            )
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
          guard let root = entities.first, let targetID = state.selection else { return .none }
          state.selection = root.id
          let n = findEntity(root: root, targetID: targetID)
          return .run { send in
            await send(.select(entity: n))
          }

        case .select(let entity):
          state.selection = entity?.id
          return .none
      }
    }
  }
}
