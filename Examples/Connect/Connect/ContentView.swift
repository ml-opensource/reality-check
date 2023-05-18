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
  var body: some View {
    ZStack {
      ARViewContainer().edgesIgnoringSafeArea(.all)
      RealityCheckConnectView()
    }
  }
}

struct ARViewContainer: UIViewRepresentable {

  func makeUIView(context: Context) -> ARView {

    let arView = ARView(frame: .zero)

    // Load the "Box" scene from the "Experience" Reality File
    let boxAnchor = try! Experience.loadBox()

    // Add the box anchor to the scene
    arView.scene.anchors.append(boxAnchor)

    return arView

  }

  func updateUIView(_ uiView: ARView, context: Context) {}

}

#if DEBUG
  struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
    }
  }
#endif
