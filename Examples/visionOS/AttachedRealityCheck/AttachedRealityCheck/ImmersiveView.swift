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

extension RealityViewContent {
  func _realityCheck(store: StoreOf<EntitiesNavigator_visionOS>) {
    guard let root = self.root else { return }
    let scene = RealityPlatform.visionOS.Scene(
      id: root.scene?.id ?? root.id,
      children: [root.encoded]
    )
    store.send(.addScene(scene))
  }
}

struct ImmersiveView: View {
  let store: StoreOf<EntitiesNavigator_visionOS>

  var body: some View {
    RealityView { content, attachments in
      // Add the initial RealityKit content
      if let scene = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
        content.add(scene)
        content._realityCheck(store: store)
      }

      if let realityCheckEntity = attachments.entity(for: "RealityCheck") {
        realityCheckEntity.position.y = 1.5
        realityCheckEntity.position.z = -1
        content.add(realityCheckEntity)
      }
    } attachments: {
      Attachment(id: "RealityCheck") {
        NavigationSplitView {
          EntitiesNavigatorView_visionOS(store: store)
            .navigationTitle("RealityCheck")
        } detail: {
          Inspector_visionOS(store: store)
        }
        .frame(maxWidth: 800, maxHeight: 600)
        .background(Color.purple.opacity(0.1).clipShape(.rect(cornerRadius: 46)))
        .tint(.purple)
      }
    }
  }
}
