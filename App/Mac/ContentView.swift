import Dependencies
import Models
import RealityDumpClient
import SwiftUI

struct ContentView: View {
    @State private var points: [SIMD3<Float>] = []
    @State private var text: String = """
        Biscuit dessert tart gummi bears pie biscuit. Pastry oat cake fruitcake chocolate cake marzipan shortbread pie toffee muffin. Marshmallow biscuit muffin sesame snaps chocolate cake candy tart. Tart biscuit croissant tiramisu powder chocolate cake chocolate bar candy canes.
        """

    @State private var identifiedEntities: [IdentifiableEntity] = []
    @State private var selection: IdentifiableEntity? = nil  // Nothing selected by default.

    @Dependency(\.realityDump) var realityDump

    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                Section("ARView") {}
                Section("Scenes") {}
                Section("Entities") {
                    OutlineGroup(identifiedEntities, children: \.children) {
                        entity in
                        NavigationLink.init(
                            value: entity,
                            label: {
                                let name: String = {
                                    if let name = entity.name, !name.isEmpty {
                                        return name
                                    } else {
                                        return entity.entityType.description
                                    }
                                }()
                                Label(
                                    name,
                                    systemImage: entity.entityType.symbol
                                )
                                .help(entity.entityType.help)
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
                        }.padding()
                    }
                    .task {
                        random()
                    }

                TextEditor(text: $text)
                    .monospaced()
                    // .font(.custom("Menlo", size: 14.0))
                    // .lineSpacing(10.0)
                    .foregroundColor(.cyan)
                    .multilineTextAlignment(.leading)
            }
        } detail: {
            Group {
                if let entity = selection {
                    EntityDetailView(entity: entity)
                } else {
                    Text("Pick an entity")
                }
            }
            // .navigationSplitViewColumnWidth(270)
        }
        .toolbar {
            Button(
                action: {
                    Task {
                        text = await realityDump.raw(
                            worldOriginAnchor,
                            printing: false,
                            org: false
                        )
                        .joined(separator: "\n")
                        identifiedEntities.removeAll()
                        identifiedEntities.append(await realityDump.identify(worldOriginAnchor))
                    }
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

    private func random() {
        points = (0..<Int.random(in: 5...55)).map { _ in
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
        ContentView()
    }
}
