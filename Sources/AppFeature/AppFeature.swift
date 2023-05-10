import ComposableArchitecture
import Models
import RealityDumpClient
import RealityKit

public struct AppCore: Reducer {
  public init() {}

  public struct State: Equatable {
    public var identifiedEntities: [IdentifiableEntity]
    @BindingState public var selected: IdentifiableEntity?
    @BindingState public var dumpOutput: String

    public init(
      identifiedEntities: [IdentifiableEntity] = [],
      selected: IdentifiableEntity? = nil,
      dumpOutput: String = """
        Biscuit dessert tart gummi bears pie biscuit.
        Pastry oat cake fruitcake chocolate cake marzipan shortbread pie toffee muffin.
        Marshmallow biscuit muffin sesame snaps chocolate cake candy tart.
        Tart biscuit croissant tiramisu powder chocolate cake chocolate bar candy canes.
        """
    ) {
      self.identifiedEntities = identifiedEntities
      self.selected = selected
      self.dumpOutput = dumpOutput
    }
  }

  public enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case entityIdentified(IdentifiableEntity)
    case parse(RealityKit.Entity)
    case dump(RealityKit.Entity)
    case dumpOutput(String)
    case select(entity: IdentifiableEntity?)
  }

  @Dependency(\.realityDump) var realityDump

  public var body: some Reducer<State, Action> {
    BindingReducer()
    
    Reduce<State, Action> { state, action in
      switch action {
        
      case .binding(\.$selected):
        return .task { [state] in
          if let entity = state.selected?.rawValue {
            return .dump(entity)
          } else {
            return .dumpOutput("...")
          }
        }
        
      case .binding:
        return .none
        
      case .entityIdentified(let identifiableEntity):
        state.identifiedEntities = [identifiableEntity]  //FIXME: allow multiple roots
        return .none

      case .parse(let entity):
        return .task {
          let identifiableEntity = await realityDump.identify(entity)
          return .entityIdentified(identifiableEntity)
        }

      case .dump(let entity):
        return .task {
          let output = await realityDump.raw(entity, org: false)
          return .dumpOutput(output.joined(separator: "\n"))
        }

      case .dumpOutput(let output):
        state.dumpOutput = output
        return .none

      case .select(let entity):
        state.selected = entity
        return .none
      }
    }
  }
}
