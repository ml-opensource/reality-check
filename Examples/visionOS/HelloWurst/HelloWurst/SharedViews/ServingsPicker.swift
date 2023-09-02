import SwiftUI

struct ServingsPicker: View {
  
  @Environment(Preferences.self)
  var preferences

  var size: CGFloat = 100
  
  var body: some View {
    @Bindable
    var preferences = preferences
    
    let shape = RoundedRectangle(cornerRadius: size / 3)

    HStack {
      Button(
        "Less",
        systemImage: "minus",
        action: { preferences.servings -= 1 }
      )
      .controlSize(.large)
      .buttonStyle(.bordered)
      .buttonBorderShape(.circle)
      .labelStyle(.iconOnly)
      .disabled(preferences.servings == 0)
      
      Spacer()
      
      Text(preferences.servings, format: .number)
        .font(.system(size: size, weight: .medium, design: .serif))
        .padding(.horizontal)
      
      Spacer()

      Button(
        "More",
        systemImage: "plus",
        action: { preferences.servings += 1 }
      )
      .controlSize(.large)
      .buttonStyle(.bordered)
      .buttonBorderShape(.circle)
      .labelStyle(.iconOnly)
      .disabled(preferences.servings == 12)
    }
#if os(visionOS)
    .padding()
    .background()
    .clipShape(shape)
#elseif os(iOS)
    .padding(8)
    .background { shape.fill(Color.primary).colorInvert() }
    .overlay { shape.stroke(.secondary) }
#endif
    .accessibilityRepresentation {
      Stepper(value: $preferences.servings, in: 1...12) {
        Text("Servings".uppercased())
      }
    }
  }
}

#Preview {
  NavigationStack {
    ServingsPicker()
      .environment(Preferences())
      .padding()
  }
}
