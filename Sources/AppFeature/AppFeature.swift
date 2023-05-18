import ComposableArchitecture
import Models
import RealityDumpClient
import RealityKit

public struct AppCore: Reducer {
  public init() {}

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

    @BindingState public var dumpOutput: String

    public init(
      identifiedEntities: IdentifiedArrayOf<IdentifiableEntity> = [],
      selection: IdentifiableEntity.ID? = nil,
      dumpOutput: String = """
        Biscuit dessert tart gummi bears pie biscuit.
        Pastry oat cake fruitcake chocolate cake marzipan shortbread pie toffee muffin.
        Marshmallow biscuit muffin sesame snaps chocolate cake candy tart.
        Tart biscuit croissant tiramisu powder chocolate cake chocolate bar candy canes.
        """
    ) {
      self.identifiedEntities = identifiedEntities
      self.selection = selection
      self.dumpOutput = dumpOutput
    }
  }

  public enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case entitiesIdentified([IdentifiableEntity])
    case parse([RealityKit.Entity])
    case dump(RealityKit.Entity)
    case dumpOutput(String)
    case select(entity: IdentifiableEntity?)
  }

  @Dependency(\.realityDump) var realityDump

  public var body: some Reducer<State, Action> {
    BindingReducer()

    Reduce<State, Action> { state, action in
      switch action {

      case .binding(\.$selection):
        return .task { [state] in
          if let entity = state.selectedEntity {
            // return .dump(entity.rawValue) //FIXME: reimplement dump avoiding RealityKit dependencies
            return .dumpOutput("...")
          } else {
            return .dumpOutput("...")
          }
        }

      case .binding:
        return .none

      case .entitiesIdentified(let identifiableEntities):
        state.identifiedEntities = .init(uniqueElements: identifiableEntities)
        return .none

      case .parse(let entities):
        return .task {
          var identifiableEntities: [IdentifiableEntity] = []
          for entity in entities {
            identifiableEntities.append(await realityDump.identify(entity))
          }
          return .entitiesIdentified(identifiableEntities)
        }

      case .dump(let entity):
        return .task {
          let output = await realityDump.raw(entity, printing: false, org: false)
          return .dumpOutput(output.joined(separator: "\n"))
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
