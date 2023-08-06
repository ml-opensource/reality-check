//
//  ContentView.swift
//  VolumeConnect
//
//  Created by Cristian Díaz on 30.06.23.
//

import SwiftUI
import RealityKit
import RealityKitContent
import RealityCheckConnect

struct ContentView: View {
  
  @State var enlarge = false
  @State private var realityCheckConnectModel = RealityCheckConnectViewModel()

  var body: some View {
    VStack {
      Model3D(named: "toy_robot_vintage")
      RealityCheckView(realityCheckConnectModel) { content, _ in
        // Add the initial RealityKit content
        if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
          content.add(scene)
        }

      } update: { content, _ in
        // Update the RealityKit content when SwiftUI state changes
        if let scene = content.entities.first {
          let uniformScale: Float = enlarge ? 1.4 : 1.0
          scene.transform.scale = [uniformScale, uniformScale, uniformScale]
        }
      }
      .gesture(TapGesture().targetedToAnyEntity().onEnded { _ in
        enlarge.toggle()
      })
            
      VStack {
        Toggle("Enlarge RealityView Content", isOn: $enlarge)
          .toggleStyle(.button)
      }.padding().glassBackgroundEffect()
    }
  }
}

#Preview {
  ContentView()
}
