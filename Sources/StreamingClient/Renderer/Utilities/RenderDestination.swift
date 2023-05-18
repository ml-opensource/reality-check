/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Requirements of a render destination that the renderer can render to.
*/

import MetalKit

// MARK: - RenderDestination

/// Defines requirements that the renderer expects the render destination to meet.
protocol RenderDestination {
    var colorPixelFormat: MTLPixelFormat { get set }
    var depthStencilPixelFormat: MTLPixelFormat { get set }
}

extension MTKView: RenderDestination { }
