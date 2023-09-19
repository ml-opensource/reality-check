//
//  ImmersiveView.swift
//  Connect
//
//  Created by Cristian Díaz on 03.09.23.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let scene = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(scene)
            }
        }
        .realityCheck()
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
