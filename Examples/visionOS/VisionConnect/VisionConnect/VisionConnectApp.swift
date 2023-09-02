//
//  VisionConnectApp.swift
//  VisionConnect
//
//  Created by Cristian Díaz on 02.09.23.
//

import SwiftUI
import RealityCheckConnect

@main
struct VisionConnectApp: App {
  @State var realityCheckConnectModel = RealityCheckConnectViewModel()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(realityCheckConnectModel)
    }
    
    ImmersiveSpace(id: "ImmersiveSpace") {
      ImmersiveView()
    }
  }
}
