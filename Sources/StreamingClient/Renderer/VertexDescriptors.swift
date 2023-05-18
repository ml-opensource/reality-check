/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A group of vertex descriptors that the renderer uses.
*/

import Metal

enum VertexDescriptors {
  // Create a vertex descriptor for the image plane vertex buffer.
  static let imagePlane: MTLVertexDescriptor = {
    let descriptor = MTLVertexDescriptor()
    // Positions.
    descriptor.attributes[0].format = .float2
    descriptor.attributes[0].offset = 0
    descriptor.attributes[0].bufferIndex = BufferIndices.kBufferIndexMeshPositions.rawValue

    // Texture coordinates.
    descriptor.attributes[1].format = .float2
    descriptor.attributes[1].offset = 8
    descriptor.attributes[1].bufferIndex = BufferIndices.kBufferIndexMeshPositions.rawValue

    // Buffer layout.
    descriptor.layouts[0].stride = 16
    descriptor.layouts[0].stepRate = 1
    descriptor.layouts[0].stepFunction = .perVertex

    return descriptor
  }()

}
