import ComposableArchitecture
import Foundation
import Models
import RealityCodable
import SwiftUI

extension RealityPlatform.visionOS.Entity {
  //FIXME: remove and use reality-codable existent properties
  public var computedName: String {
    if let name = self.name, !name.isEmpty {
      return name
    } else {
      return "\(type(of: self))"
    }
  }
}

extension RealityPlatform.visionOS.Entity {
  public var systemImage: String {
    switch "\(type(of: self))" {
      case "AnchorEntity":
        return "arrow.down.to.line"
      case "Entity":
        return "move.3d"
      case "ModelEntity":
        return "cube"
      case "PerspectiveCamera":
        return "camera"
      case "TriggerVolume":
        return "cube.transparent"
      default:
        return "move.3d"
    }
  }
}

@Reducer public struct EntitiesNavigator_visionOS {
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
      self.dumpOutput = "⚠️ Dump output not received. Check the connection state."
    }
  }

  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case delegate(DelegateAction)
    case dumpOutput(String)
    case refreshEntities([RealityPlatform.visionOS.Entity])
  }

  public enum DelegateAction: Equatable {
    case didSelectEntity(RealityPlatform.visionOS.Entity.ID)
  }

  public var body: some Reducer<State, Action> {
    BindingReducer()

    Reduce<State, Action> { state, action in
      switch action {
        case .binding(\.$selection):
          if let entity = state.selectedEntity {
            return .send(.delegate(.didSelectEntity(entity.id)))
          } else {
            return .none
          }

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

//MARK: - View

extension RealityPlatform.visionOS.Entity {
  public var childrenOptional: [RealityPlatform.visionOS.Entity]? {
    children.isEmpty ? nil : children.map(\.value)
  }
}

public struct EntitiesNavigatorView_visionOS: View {
  let store: StoreOf<EntitiesNavigator_visionOS>
  @State private var searchText: String = ""

  public init(store: StoreOf<EntitiesNavigator_visionOS>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List(selection: viewStore.$selection) {
        Section(header: Text("Entities")) {
          OutlineGroup(
            viewStore.entities.elements,
            children: \.childrenOptional
          ) { entity in
            let isUnnamed = entity.name?.isEmpty ?? true

            Label(
              entity.computedName,
              systemImage: entity.parentID == nil
                ? "uiwindow.split.2x1"
                : entity.systemImage
            )
            .italic(isUnnamed)

            // FIXME: .help(entity.entityType.help)
            // .accessibilityLabel(Text(entity.accessibilityLabel ?? ""))
            // .accessibilityValue(Text(entity.accessibilityDescription ?? ""))
          }
        }
        .collapsible(false)
      }
      .searchable(text: $searchText, placement: .sidebar, prompt: "Search Entities")
    }
  }
}
