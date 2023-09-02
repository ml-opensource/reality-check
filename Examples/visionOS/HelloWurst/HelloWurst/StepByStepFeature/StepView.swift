import SwiftUI

struct StepView: View {
  let step: Recipe.Step
  
  @Environment(\.openWindow)
  var openWindow
  
  var body: some View {
    VStack {
      Text("Step: " + step.name)
        .font(.largeTitle)
        .fontDesign(.serif)
      
      if let time = step.time {
        Button(
          time.formatted(),
          systemImage: "clock.badge",
          action: { openWindow(id: "Clock") }
        )
        .buttonStyle(.bordered)
      }
    }
  }
}

#Preview {
  StepView(step: .init(name: "Hello, Step!", time: .init(.seconds(60 * 5))))
}
