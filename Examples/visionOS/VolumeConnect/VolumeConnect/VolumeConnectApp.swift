//
//  VolumeConnectApp.swift
//  VolumeConnect
//
//  Created by Cristian Díaz on 30.06.23.
//

import SwiftUI

@main
struct VolumeConnectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.windowStyle(.volumetric)
    }
}
