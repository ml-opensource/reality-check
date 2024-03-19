//
//  AttachedRealityCheckApp.swift
//  AttachedRealityCheck
//
//  Created by Cristian Díaz Peredo on 18.03.24.
//

import ComposableArchitecture
import EntitiesNavigator_visionOS
import SwiftUI

@main
struct AttachedRealityCheckApp: App {
  let store = Store(initialState: EntitiesNavigator_visionOS.State()) {
    EntitiesNavigator_visionOS()
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    
    RealityCheckWindow(store: store)

    ImmersiveSpace(id: "ImmersiveSpace") {
      ImmersiveView(store: store)
    }
  }
}
