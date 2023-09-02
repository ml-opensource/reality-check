//
//  ContentView.swift
//  VisionConnect
//
//  Created by Cristian Díaz on 02.09.23.
//

import SwiftUI
import RealityKit
import RealityKitContent
import RealityCheckConnect

struct ContentView: View {
  
  @State private var showImmersiveSpace = false
  @State private var immersiveSpaceIsShown = false
  
  @Environment(\.openImmersiveSpace) var openImmersiveSpace
  @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
  @Environment(RealityCheckConnectViewModel.self) private var realityCheckConnectModel
  
  var body: some View {
    VStack {
      Model3D(named: "Scene", bundle: realityKitContentBundle)
      .padding(.bottom, 50)
      .accessibilityElement()
      .accessibilityValue("Accessible Sphere")
      
      RealityView { content in
        let referenceEntity = ModelEntity(mesh: .generateBox(size: 0.15))
        referenceEntity.name = "RealityCheck-reference"
        referenceEntity.isAccessibilityElement = true
        content.add(referenceEntity)
        
        await realityCheckConnectModel.sendMultipeerData(content)
      }
      
      Text("Hello, world!")
      
      Toggle("Show Immersive Space", isOn: $showImmersiveSpace)
        .toggleStyle(.button)
        .padding(.top, 50)
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
    .task {
      await realityCheckConnectModel.startMultipeerSession()
    }
  }
}

#Preview(windowStyle: .automatic) {
  ContentView()
}
