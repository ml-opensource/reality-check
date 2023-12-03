//
//  ContentView.swift
//  Connect
//
//  Created by Cristian Díaz on 18.05.23.
//

import RealityCheckConnect
import RealityKit
import SwiftUI

struct ContentView: View {
  let arViewContainer = ARViewContainer()
  var body: some View {
    ZStack {
      arViewContainer.edgesIgnoringSafeArea(.all)
      RealityCheckConnectView(arViewContainer.arView)
    }
  }
}

struct ARViewContainer: UIViewRepresentable {

  let arView = ARView(frame: .zero)

  func makeUIView(context: Context) -> ARView {

    // Load the "Box" scene from the "Experience" Reality File
    let boxAnchor = try! Experience.loadBox()

    // Add the box anchor to the scene
    arView.scene.anchors.append(boxAnchor)

    return arView

  }

  func updateUIView(_ uiView: ARView, context: Context) {}

}

#Preview {
  ContentView()
}
