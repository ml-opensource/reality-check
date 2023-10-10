//
//  ImmersiveView.swift
//  Connect
//
//  Created by Cristian Díaz on 03.09.23.
//

import SwiftUI
import RealityKit
import RealityKitContent
import RealityCheckConnect

struct ImmersiveView: View {
  
  @Environment(RealityCheckConnectViewModel.self)
  var realityCheckConnectModel
  
  let attachmentID = "attachmentID"

  var body: some View {
    VStack {
      // RealityView { content in
      //   // Add the initial RealityKit content
      //   if let scene = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
      //     content.add(scene)
      //   }
      // }
      
      
      RealityView { content, attachments in
        if let scene = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
          content.add(scene)
        }
        if let sceneAttachment = attachments.entity(for: attachmentID) {
          sceneAttachment.position = .one
          content.add(sceneAttachment)
        }
        
      } update: { content, attachments in
        print(attachments)
      } attachments: {
        Attachment(id: attachmentID) {
          Button("Start Immersive video stream") {
            Task {
              await realityCheckConnectModel.startVideoStreaming()
            }
          }
        }
      }
     // .realityCheck()
    }
  }
}

#Preview {
  ImmersiveView()
    .previewLayout(.sizeThatFits)
}
