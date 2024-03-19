//
//  RealityViewContent+RealityCheck.swift
//
//
//  Created by Cristian Díaz Peredo on 19.03.24.
//

import ComposableArchitecture
import Foundation
import Models
import RealityKit
import SwiftUI

extension RealityViewContent {
  public func _realityCheck(store: StoreOf<EntitiesNavigator_visionOS>) {
    guard let root = self.root else { return }
    let scene = RealityPlatform.visionOS.Scene(
      id: root.scene?.id ?? root.id,
      children: [root.encoded]
    )
    store.send(.addScene(scene))
  }
}
