import ComposableArchitecture
import SwiftUI

struct ARViewSectionView: View {
  @State var store: StoreOf<ARViewSection>

  var body: some View {
    //FIXME: improve display
    GroupBox {
      VStack {
        Button.init("ARView", systemImage: "cube.transparent") {
          store.isDebugOptionsDisplayed = true
        }

        Button(
          action: {},
          label: {
            HStack {
              Label.init("ARView", systemImage: "cube.transparent")
                .foregroundColor(
                  store.isSelected
                    ? Color(nsColor: .alternateSelectedControlTextColor)
                    : Color(nsColor: .controlTextColor)
                )
              Spacer()
            }
            .padding()
            .background(
              RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(
                  store.isSelected
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
              store.isDebugOptionsDisplayed = true
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
            isPresented: $store.isDebugOptionsDisplayed,
            arrowEdge: .trailing
          ) {
            DebugOptionsView(
              store: store.scope(
                state: \.debugOptions,
                action: \.debugOptions
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
    .padding(.horizontal, 6)
  }
}
