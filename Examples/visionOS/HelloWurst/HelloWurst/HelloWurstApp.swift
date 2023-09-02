import SwiftUI
import RealityCheckConnect

@main
struct HelloWurstApp: App {
  
  @State private
  var model = AppCoreFeatureModel(recipes: Recipe.samples)
  
  @State private
  var realityCheckConnectModel = RealityCheckConnectViewModel()
  
  @State private
  var preferences = Preferences()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(model)
        .environment(preferences)
    }
    
#if os(visionOS)
    WindowGroup.init(id: "Clock") {
      ClockView()
        .environment(realityCheckConnectModel)
    }
    .windowStyle(.volumetric)
#endif
  }
}
