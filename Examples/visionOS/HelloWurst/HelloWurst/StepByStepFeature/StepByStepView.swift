import SwiftUI

struct StepByStepView: View {
  @Environment(StepByStepFeatureModel.self) private var model
  
  var body: some View {
    @Bindable var model = model
    
    TabView {
      ForEach(model.steps) { step in
        VStack {
          StepView(step: step)
          
          if step == model.steps.last {
            Button(
              "Mark as cooked".uppercased(),
              systemImage: "checkmark",
              action: { model.didComplete() }
            )
            .controlSize(.extraLarge)
#if os(iOS)
            .buttonStyle(.borderedProminent)
#endif
          }
        }
        .tag(step)
      }
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
    .onChange(of: model.current) { oldValue, newValue in
      print(oldValue, newValue)
    }
  }
}

#Preview {
  NavigationStack {
    StepByStepView()
      .environment(StepByStepFeatureModel(steps: Recipe.samples[0].steps))
  }
}
