import AppFeature
import ComposableArchitecture
import Dependencies
import Models
import SwiftUI

struct ContentView: View {
  @State private var points: [SIMD3<Float>] = []
  let store: StoreOf<AppCore>

  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      NavigationSplitView {
        List(selection: viewStore.binding(\.$selected)) {
          Section("ARView") {}
          Section("Scenes") {}
          Section("Entities") {
            OutlineGroup(viewStore.identifiedEntities, children: \.children) {
              entity in
              NavigationLink.init(
                value: entity,
                label: {
                  if let name = entity.name,
                    !name.isEmpty
                  {
                    Label(
                      title: {
                        VStack(alignment: .leading) {
                          Text(name)
                          Text(entity.entityType.description)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        }
                      },
                      icon: { Image(systemName: entity.entityType.symbol) }
                    )
                    .help(entity.entityType.help)
                  } else {
                    Label(entity.entityType.description, systemImage: entity.entityType.symbol)
                      .help(entity.entityType.help)
                  }
                }
              )
            }
          }
        }
      } content: {
        VSplitView {
          ARContainerView(points: points)
            .ignoresSafeArea()
            .overlay(alignment: .bottom) {
              HStack {
                Button("Random") {
                  random()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
              }
              .padding()
            }
            .task {
              random()
            }

          TextEditor(text: viewStore.binding(\.$dumpOutput))
            .monospaced()
            // .font(.custom("Menlo", size: 14.0))
            // .lineSpacing(10.0)
            .foregroundColor(.cyan)
            .multilineTextAlignment(.leading)

        }
      } detail: {
        Group {
          if let entity = viewStore.selected {
            EntityDetailView(entity: entity)
          } else {
            Text("Pick an entity")
          }
        }
        .navigationSplitViewColumnWidth(min: 270, ideal: 405)
        .navigationSplitViewStyle(.prominentDetail)
      }
      .toolbar {
        Button(
          action: {
            viewStore.send(.dump(worldOriginAnchor))
            viewStore.send(.parse(worldOriginAnchor))
          },
          label: { Label("Dump", systemImage: "ladybug") }
        )
      }
      // .onChange(of: \.selection) { entity in
      //     //TODO: dump selected entity
      //     text = await realityDump.raw(
      //         entity,
      //         printing: false,
      //         org: false
      //     )
      //     .joined(separator: "\n")
      // }
    }
  }

  private func random() {
    points = (0..<Int.random(in: 5...55))
      .map { _ in
        SIMD3<Float>(
          x: Float.random(in: -1...1),
          y: Float.random(in: 0...1),
          z: Float.random(in: -1...1)
        )
      }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(
      store: .init(
        initialState: AppCore.State(),
        reducer: AppCore()
      )
    )
  }
}
