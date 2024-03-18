//
//  ContentView.swift
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

struct ContentView: View {
  let store: StoreOf<EntitiesNavigator_visionOS>

  @State private var showImmersiveSpace = false
  @State private var immersiveSpaceIsShown = false

  @Environment(\.openImmersiveSpace) var openImmersiveSpace
  @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

  var body: some View {
    HStack {
      EntitiesNavigatorView_visionOS(store: store)

      Divider()

      VStack {
        RealityView { content in
          // Add the initial RealityKit content
          if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
            content.add(scene)

            guard let root = content.root else { return }
            let scene = RealityPlatform.visionOS.Scene(children: [root.encoded])
            let entities = scene.children.map(\.value)
            store.send(.refreshEntities(entities))
          }
        }

        Toggle("Show ImmersiveSpace", isOn: $showImmersiveSpace)
          .font(.title)
          .frame(width: 360)
          .padding(24)
          .glassBackgroundEffect()
      }
      .padding(.bottom, 50)
    }
    .padding()
    .onChange(of: showImmersiveSpace) { _, newValue in
      Task {
        if newValue {
          switch await openImmersiveSpace(id: "ImmersiveSpace") {
            case .opened:
              immersiveSpaceIsShown = true
            case .error, .userCancelled:
              fallthrough
            @unknown default:
              immersiveSpaceIsShown = false
              showImmersiveSpace = false
          }
        } else if immersiveSpaceIsShown {
          await dismissImmersiveSpace()
          immersiveSpaceIsShown = false
        }
      }
    }
  }
}
