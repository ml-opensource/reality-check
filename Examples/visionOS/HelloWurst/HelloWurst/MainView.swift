import SwiftUI

struct MainView: View {
  var body: some View {
    TabView {
      TodayView()
        .tabItem { Label("Today", systemImage: "sun.horizon.fill") }
      
      Text("For you")
        .tabItem { Label("For you", systemImage: "calendar") }
      
      Text("Favorites")
        .tabItem { Label("Favorites", systemImage: "heart.fill") }
      
      Text("Shopping")
        .tabItem { Label("Shopping", systemImage: "suitcase.fill") }
      
      Text("Profile")
        .tabItem { Label("Profile", systemImage: "person.fill") }
    }
  }
}

#Preview {
  MainView()
    .environment(AppCoreFeatureModel(recipes: Recipe.samples))
    .environment(Preferences())
}
