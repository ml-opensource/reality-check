//
//  ConnectApp.swift
//  Connect
//
//  Created by Cristian Díaz on 03.09.23.
//

import RealityCheckConnect
import SwiftUI

@main
struct ConnectApp: App {
    @State var realityCheckConnectModel = RealityCheckConnectViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(realityCheckConnectModel)
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
