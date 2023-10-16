import ComposableArchitecture
import Foundation
import RealityCodable

//TODO: rename to `EntitiesInspector`
public struct EntitiesSection: Reducer {
  public struct State: Equatable {
    public var entities: IdentifiedArrayOf<RealityPlatform.visionOS.Entity>

    @BindingState public var dumpOutput: String
    @BindingState public var selection: RealityPlatform.visionOS.Entity.ID?

    public var selectedEntity: RealityPlatform.visionOS.Entity? {
      guard let selection else { return nil }
      for rootEntity in entities {
        if let entity = RealityPlatform.visionOS.Scene.findEntity(id: selection, root: rootEntity) {
          return entity
        }
      }
      return nil
    }

    public init(
      _ entities: [RealityPlatform.visionOS.Entity],
      selection: RealityPlatform.visionOS.Entity.ID? = nil
    ) {
      self.entities = .init(uniqueElements: entities)
      self.selection = selection ?? self.entities.first?.id
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
    case refreshEntities([RealityPlatform.visionOS.Entity])
  }

  public enum DelegateAction: Equatable {
    case didToggleSelectSection
    case didSelectEntity(RealityPlatform.visionOS.Entity.ID)
  }

  public var body: some Reducer<State, Action> {
    BindingReducer()

    Reduce<State, Action> { state, action in
      switch action {
      case .binding(\.$selection):
        //FIXME:
        return .none
      // if let entity = state.selectedEntity {
      //   return .merge(
      //     .send(.delegate(.didToggleSelectSection)),
      //     .send(.delegate(.didSelectEntity(entity.id)))
      //   )
      // } else {
      //   return .send(.delegate(.didToggleSelectSection))
      // }

      case .binding:
        return .none

      case .delegate(_):
        return .none

      case .dumpOutput(let output):
        state.dumpOutput = output
        return .none

      case .refreshEntities(let entities):
        state.entities = .init(uniqueElements: entities)
        guard let previousSelection = state.selection else { return .none }
        state.selection = nil
        return .send(.binding(.set(\.$selection, previousSelection)))
      }
    }
  }
}
