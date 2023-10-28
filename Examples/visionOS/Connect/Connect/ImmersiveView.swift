//
//  ImmersiveView.swift
//  Connect
//
//  Created by Cristian Díaz on 08.10.23.
//

import SwiftUI
import RealityKit
import RealityKitContent
import RealityCheckConnect

struct ImmersiveView: View {
    var body: some View {
        RealityCheckView { content in
            // Add the initial RealityKit content
            if let scene = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(scene)
            }
        }
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
