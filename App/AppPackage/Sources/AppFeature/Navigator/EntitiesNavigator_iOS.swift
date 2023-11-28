import ComposableArchitecture
import Foundation
import Models
import RealityCodable
//MARK: - View
import SwiftUI

extension RealityPlatform.iOS.Entity {
  //FIXME: remove and use reality-codable existent properties
  public var computedName: String {
    if let name = self.name, !name.isEmpty {
      return name
    } else {
      return "\(type(of: self))"
    }
  }
}

extension RealityPlatform.iOS.Entity {
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

@Reducer
public struct EntitiesNavigator_iOS {

  @ObservableState
  public struct State: Equatable {
    public var arViewSection: ARViewSection.State?
    public var entities: IdentifiedArrayOf<RealityPlatform.iOS.Entity>

    public var dumpOutput: String
    public var selection: RealityPlatform.iOS.Entity.ID?

    public var selectedEntity: RealityPlatform.iOS.Entity? {
      guard let selection else { return nil }
      for rootEntity in entities {
        if let entity = RealityPlatform.iOS.Scene.findEntity(id: selection, root: rootEntity) {
          return entity
        }
      }
      return nil
    }

    public init(
      _ entities: [RealityPlatform.iOS.Entity],
      arViewSection: ARViewSection.State? = nil,
      selection: RealityPlatform.iOS.Entity.ID? = nil
    ) {
      let _entities = IdentifiedArrayOf<RealityPlatform.iOS.Entity>(uniqueElements: entities)
      self.entities = _entities
      self.arViewSection = arViewSection
      self.selection = selection ?? _entities.first?.id
      self.dumpOutput = "⚠️ Dump output not received. Check the connection state."
    }
  }

  public enum Action: BindableAction, Equatable {
    case arViewSection(ARViewSection.Action)
    case binding(BindingAction<State>)
    case delegate(DelegateAction)
    case dumpOutput(String)
    case refreshEntities([RealityPlatform.iOS.Entity])
  }

  public enum DelegateAction: Equatable {
    case didSelectEntity(RealityPlatform.iOS.Entity.ID)
  }

  public var body: some Reducer<State, Action> {
    BindingReducer()

    Reduce<State, Action> { state, action in
      switch action {
        case .arViewSection(_):
          return .none

        case .binding(\.selection):
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
          return .send(.binding(.set(\.selection, previousSelection)))
      }
    }
    .ifLet(\.arViewSection, action: \.arViewSection) {
      ARViewSection()
    }
  }
}

extension RealityPlatform.iOS.Entity {
  public var childrenOptional: [RealityPlatform.iOS.Entity]? {
    children.isEmpty ? nil : children.map(\.value)
  }
}

public struct EntitiesNavigatorView_iOS: View {
  @State var store: StoreOf<EntitiesNavigator_iOS>
  @State private var searchText: String = ""

  public init(store: StoreOf<EntitiesNavigator_iOS>) {
    self.store = store
  }

  public var body: some View {
    List(selection: $store.selection) {
      Section("ARView Debug Options") {
        if let childStore = store.scope(
          state: \.arViewSection?.debugOptions,
          action: \.arViewSection.debugOptions
        ) {
          DebugOptionsView(store: childStore)
        }
      }

      Section("Entities") {
        OutlineGroup(
          store.entities.elements,
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
    .listStyle(.sidebar)
    .searchable(text: $searchText, placement: .sidebar, prompt: "Search Entities")
  }
}