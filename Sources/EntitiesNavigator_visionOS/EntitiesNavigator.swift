import ComposableArchitecture
import Foundation
import Models
import RealityCodable
import SwiftUI

@Reducer
public struct EntitiesNavigator_visionOS {
  public init() {}

  @ObservableState
  public struct State: Equatable {
    public var entities: IdentifiedArrayOf<RealityPlatform.visionOS.Entity> {
      var entities: [RealityPlatform.visionOS.Entity] = []
      for scene in scenes {
        let children = scene.children.map(\.value)
        entities.append(contentsOf: children)
      }
      return .init(uniqueElements: entities)
    }
    public var scenes: IdentifiedArrayOf<RealityPlatform.visionOS.Scene> = []
    // public var filteredEntities: IdentifiedArrayOf<RealityPlatform.visionOS.Entity>
    public var dumpOutput: String
    // var searchQuery = ""

    public var selection: RealityPlatform.visionOS.Entity.ID?
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
      // _ entities: [RealityPlatform.visionOS.Entity],
      selection: RealityPlatform.visionOS.Entity.ID? = nil
    ) {
      // self.entities = .init(uniqueElements: entities)
      // self.filteredEntities = .init(uniqueElements: entities)
      // self.selection = selection ?? entities.first?.id
      self.selection = selection
      self.dumpOutput = "⚠️ Dump output not received. Check the connection state."
    }
  }

  public enum Action: BindableAction, Equatable {
    case addScene(RealityPlatform.visionOS.Scene)
    case binding(BindingAction<State>)
    case delegate(DelegateAction)
    case dumpOutput(String)
    // case refreshEntities([RealityPlatform.visionOS.Entity])
    // case searchQueryChangeDebounced
  }

  public enum DelegateAction: Equatable {
    case didSelectEntity(RealityPlatform.visionOS.Entity.ID)
  }

  public var body: some Reducer<State, Action> {
    BindingReducer()

    Reduce<State, Action> { state, action in
      switch action {
        // case .binding(\.searchQuery):
        //   print(state.searchQuery)
        //   state.filteredEntities = state.entities.filter {
        //     $0.name?.contains(state.searchQuery) ?? false
        //   }
        //   return .none

        case let .addScene(scene):
          state.scenes.append(scene)
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

      // case .refreshEntities(let entities):
      //   //state.entities = .init(uniqueElements: entities)
      //   guard let previousSelection = state.selection else { return .none }
      //   state.selection = nil
      //   return .send(.binding(.set(\.selection, previousSelection)))

      //FIXME: crash
      // case .searchQueryChangeDebounced:
      //   guard !state.searchQuery.isEmpty, state.searchQuery.count > 1 else {
      //     state.filteredEntities = state.entities
      //     return .none
      //   }
      //   state.filteredEntities = state.entities.filter({ entity in
      //    // entity.name?.lowercased().contains(state.searchQuery.lowercased()) ?? false
      //     entity.name?.localizedCaseInsensitiveContains(state.searchQuery)  ?? false
      //   })
      //   return .none
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
  @State var store: StoreOf<EntitiesNavigator_visionOS>

  public init(store: StoreOf<EntitiesNavigator_visionOS>) {
    self.store = store
  }

  public var body: some View {
    List(selection: $store.selection) {
      Section(header: Text("Entities")) {
        OutlineGroup(
          store.entities.elements,
          children: \.childrenOptional
        ) { entity in
          Label(
            entity.computedName,
            systemImage: entity.parentID == nil
              ? "uiwindow.split.2x1"
              : entity.systemImage
          )
          .accessibilityLabel(entity._accessibilityLabel)
          // FIXME: .help(entity.entityType.help)
        }
      }

      //FIXME: not available on visionOS // .collapsible(false)
    }
    // .listStyle(.sidebar)
    //FIXME: Search binding crashes: *** -[NSBigMutableString substringWithRange:]: Range {0, 1} out of bounds; string length 0
    // .searchable(text: $store.searchQuery, placement: .sidebar, prompt: "Search Entities")
    // .task(id: store.searchQuery) {
    //   do {
    //     try await Task.sleep(for: .milliseconds(300))
    //     await store.send(.searchQueryChangeDebounced).finish()
    //   } catch {}
    // }
  }
}
