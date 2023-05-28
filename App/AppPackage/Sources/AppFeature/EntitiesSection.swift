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
    case dumpOutput(String)
    case select(entity: IdentifiableEntity?)
  }

  public var body: some Reducer<State, Action> {
    BindingReducer()

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
