//
//  ContentView.swift
//  IntricateSetup
//
//  Created by Cristian Díaz on 20.06.23.
//

import SwiftUI
import RealityKit
import MyLibrary

struct ContentView : View {
    var body: some View {
         ARViewContainer()
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
