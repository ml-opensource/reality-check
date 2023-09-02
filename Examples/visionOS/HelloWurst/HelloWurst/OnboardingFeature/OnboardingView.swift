import SwiftUI

struct OnboardingView: View {
  @Environment(OnboardingFeatureModel.self) private var model
  
  var body: some View {
    @Bindable var model = model
    
    NavigationStack(path: $model.navigationPath) {
      PresentationView()
        .background(Color.black)
        .ignoresSafeArea()
        .navigationDestination(for: OnboardingFeatureModel.Destination.self) { destination in
          switch destination {
          case .goals:
            GoalsSelector()
            
          case .diet:
            DietSelector()
            
          case .servings:
            ServingsCounter()
            
          case .almost:
            AlmostThere()
          }
        }
    }
  }
}

#Preview {
  OnboardingView()
    .environment(OnboardingFeatureModel())
    .environment(Preferences())
}

