//
//  ContentView.swift
//  SpatialConnect
//
//  Created by Cristian Díaz on 29.06.23.
//

import SwiftUI
import RealityKit
import RealityKitContent
import RealityCheckConnect

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            List {
                Text("Item")
            }
            .navigationTitle("Sidebar")
        } detail: {
          ZStack {
            RealityCheckConnectView()
            VStack {
              Model3D(named: "Scene", bundle: realityKitContentBundle)
                .padding(.bottom, 50)
              
              Text("Hello, world!")
            }
          }
            .navigationTitle("Content")
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
