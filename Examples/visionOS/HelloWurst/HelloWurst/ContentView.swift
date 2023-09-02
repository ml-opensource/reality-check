import SwiftUI

struct ContentView: View {
  @Environment(AppCoreFeatureModel.self) private var model
  @Environment(Preferences.self) private var preferences
  
  var body: some View {
    @Bindable var model = model
    
    MainView()
      .fullScreenCover(isPresented: $model.isOnboadingPresented) {
        OnboardingView()
          .environment(model.onboardingModel)
          .environment(preferences)
      }
  }
}

#Preview {
  ContentView()
    .environment(AppCoreFeatureModel())
    .environment(Preferences())
    .previewDisplayName("Onboarding")
}

#Preview {
  ContentView()
    .environment(
      AppCoreFeatureModel(
        destination: .main,
        recipes: Recipe.samples)
    )
    .environment(Preferences())
    .previewDisplayName("Main")
}
