/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A group of depth-stencil states that the renderer uses.
*/

import Metal

// MARK: - DepthStencilStates
struct DepthStencilStates {
    
    let videoStream: MTLDepthStencilState
        
    init(device: MTLDevice) {
        videoStream = MetalUtils.makeDepthStencilState(device: device, label: "Video Stream") { descriptor in
            descriptor.isDepthWriteEnabled = false
            descriptor.depthCompareFunction = .always
        }
    }
}
