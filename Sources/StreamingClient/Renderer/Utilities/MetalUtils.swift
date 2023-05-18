/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Utility functions for creating a renderer.
*/

import Metal

enum MetalUtils {
    
    static func makeRenderPipelineState(device: MTLDevice,
                                        label: String,
                                        block: (MTLRenderPipelineDescriptor) -> Void) -> MTLRenderPipelineState {
        let descriptor = MTLRenderPipelineDescriptor()
        block(descriptor)
        descriptor.label = label
        do {
            return try device.makeRenderPipelineState(descriptor: descriptor)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    static func makeDepthStencilState(device: MTLDevice,
                                      label: String,
                                      block: (MTLDepthStencilDescriptor) -> Void) -> MTLDepthStencilState {
        let descriptor = MTLDepthStencilDescriptor()
        block(descriptor)
        descriptor.label = label
        if let depthStencilState = device.makeDepthStencilState(descriptor: descriptor) {
            return depthStencilState
        } else {
            fatalError("Failed to create depth-stencil state.")
        }
    }
    
    static func encodePass(into commandBuffer: MTLCommandBuffer,
                           using descriptor: MTLRenderPassDescriptor,
                           label: String,
                           _ encodingBlock: (MTLRenderCommandEncoder) -> Void) {
        guard let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: descriptor) else {
            fatalError("Failed to make render command encoder with: \(descriptor.description)")
        }
        renderEncoder.label = label
        encodingBlock(renderEncoder)
        renderEncoder.endEncoding()
    }
    
    static func encodeStage(using renderEncoder: MTLRenderCommandEncoder,
                            label: String,
                            _ encodingBlock: () -> Void) {
        renderEncoder.pushDebugGroup(label)
        encodingBlock()
        renderEncoder.popDebugGroup()
    }
}
