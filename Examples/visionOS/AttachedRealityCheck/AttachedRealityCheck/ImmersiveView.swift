//
//  ImmersiveView.swift
//  AttachedRealityCheck
//
//  Created by Cristian Díaz Peredo on 18.03.24.
//

import ComposableArchitecture
import EntitiesNavigator_visionOS
import Models
import RealityKit
import RealityKitContent
import SwiftUI

struct ImmersiveView: View {
  let store: StoreOf<EntitiesNavigator_visionOS>

  var body: some View {
    RealityView { content in
      // Add the initial RealityKit content
      if let scene = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
        content.add(scene)

        guard let root = content.root else { return }
        let scene = RealityPlatform.visionOS.Scene(children: [root.encoded])
        let entities = scene.children.map(\.value)
        store.send(.refreshEntities(entities))
      }
    }
  }
}
