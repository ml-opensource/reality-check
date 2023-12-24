import ComposableArchitecture
import Foundation
import Models
import RealityCodable
import SwiftUI

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
      self.entities = .init(uniqueElements: entities)
      self.arViewSection = arViewSection
      self.selection = selection ?? entities.first?.id
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
            systemImage: entity.systemImage
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
    //FIXME: restore when related crash is resolved: .searchable(text: $searchText, placement: .sidebar, prompt: "Search Entities")
  }
}
