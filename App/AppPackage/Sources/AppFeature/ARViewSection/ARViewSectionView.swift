import ComposableArchitecture
import SwiftUI

struct ARViewSectionView: View {
  let store: StoreOf<ARViewSection>

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      GroupBox {
        VStack {
          Button(
            action: {
              viewStore.send(.toggleSelection)
            },
            label: {
              HStack {
                Label.init("ARView", systemImage: "cube.transparent")
                  .foregroundColor(
                    viewStore.isSelected
                      ? Color(nsColor: .alternateSelectedControlTextColor)
                      : Color(nsColor: .controlTextColor)
                  )
                Spacer()
              }
              .padding()
              .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                  .fill(
                    viewStore.isSelected
                      ? Color(nsColor: .controlAccentColor)
                      : Color(nsColor: .controlBackgroundColor)
                  )
              )
            }
          )
          .controlSize(.large)
          .buttonStyle(.plain)
          .overlay(alignment: .trailing) {
            Button(
              action: {
                viewStore.send(.binding(.set(\.$isDebugOptionsDisplayed, true)))
              },
              label: {
                Label("Debug Options", systemImage: "ladybug")
                  .labelStyle(.iconOnly)
                  .padding(4)
                  .background(Circle().foregroundColor(.gray.opacity(0.25)))
              }
            )
            .controlSize(.small)
            .buttonStyle(.plain)
            .padding(.trailing, 4)
            .help("ARView Debug Options")
            .popover(
              isPresented: viewStore.$isDebugOptionsDisplayed,
              arrowEdge: .trailing
            ) {
              DebugOptionsView(
                store: store.scope(
                  state: \.debugOptions,
                  action: ARViewSection.Action.debugOptions
                )
              )
              .padding()
            }
          }

          Menu("Scenes") {
            Button("Scene 1", action: {})
            Button("Scene 2", action: {})
            Button("Scene 3", action: {})
          }
          .controlSize(.large)
          .disabled(true)  //TODO: implement scene selection
        }
        .padding(8)
      }
    }
    .padding([.horizontal], 6)
  }
}
