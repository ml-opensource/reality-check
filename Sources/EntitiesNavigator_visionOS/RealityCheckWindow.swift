//
//  RealityCheckWindow.swift
//
//
//  Created by Cristian Díaz Peredo on 19.03.24.
//

import ComposableArchitecture
import SwiftUI

public struct RealityCheckWindow: Scene {
  let store: StoreOf<EntitiesNavigator_visionOS>

  public init(store: StoreOf<EntitiesNavigator_visionOS>) {
    self.store = store
  }

  public var body: some Scene {
    WindowGroup(id: "RealityCheckWindow") {
      InlineRealityCheckView(store: store)
    }
    .defaultSize(width: 1000, height: 600)
  }
}
