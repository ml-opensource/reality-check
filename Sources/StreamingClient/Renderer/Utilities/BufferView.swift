/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Type-safe utility for working with MTLBuffers.
*/

import MetalKit

/// A wrapper around MTLBuffer that provides type-safe access and assignment to the underlying MTLBuffer's contents.
struct BufferView<Element> {
        
    /// The underlying MTLBuffer.
    fileprivate let buffer: MTLBuffer
    
    /// The number of Elements the buffer can hold.
    private let count: Int
    
    private var stride: Int {
        MemoryLayout<Element>.stride
    }

    /// Initializes the buffer with zeros. The buffer receives an appropriate length according to the provided element count.
    init(device: MTLDevice, count: Int, label: String? = nil, options: MTLResourceOptions = []) {
        
        guard let buffer = device.makeBuffer(length: MemoryLayout<Element>.stride * count, options: options) else {
            fatalError("Failed to create MTLBuffer.")
        }
        self.buffer = buffer
        self.buffer.label = label
        self.count = count
    }
    
    /// Initializes the buffer with the contents of the provided array.
    init(device: MTLDevice, array: [Element], options: MTLResourceOptions = []) {
        
        guard let buffer = device.makeBuffer(bytes: array, length: MemoryLayout<Element>.stride * array.count, options: .storageModeShared) else {
            fatalError("Failed to create MTLBuffer")
        }
        self.buffer = buffer
        self.count = array.count
    }
    
    /// Replaces the buffer's memory at the specified element index with the provided value.
    func assign(_ value: Element, at index: Int = 0) {
        precondition(index <= count - 1, "Index \(index) is greater than maximum allowable index of \(count - 1) for this buffer.")
        withUnsafePointer(to: value) {
            buffer.contents().advanced(by: index * stride).copyMemory(from: $0, byteCount: stride)
        }
    }
    
    /// Replaces the buffer's memory with the values in the array.
    func assign(with array: [Element]) {
        let byteCount = array.count * stride
        precondition(byteCount == buffer.length, "Mismatch between the byte count of the array's contents and the MTLBuffer length.")
        buffer.contents().copyMemory(from: array, byteCount: byteCount)
    }
    
    /// Returns a copy of the value at the specified element index in the buffer.
    subscript(index: Int) -> Element {
        precondition(stride * index <= buffer.length - stride, "This buffer is not large enough to have an element at the index: \(index)")
        return buffer.contents().advanced(by: index * stride).load(as: Element.self)
    }
}

// Note: This extension is in this file because access to Buffer<Element>.buffer is fileprivate.
// Access to Buffer<T>.buffer is fileprivate to ensure that only this file can touch the underlying MTLBuffer.
extension MTLRenderCommandEncoder {
    func setVertexBuffer<T>(_ vertexBuffer: BufferView<T>?, offset: Int, index: Int) {
        setVertexBuffer(vertexBuffer?.buffer, offset: offset, index: index)
    }
    
    func setFragmentBuffer<T>(_ fragmentBuffer: BufferView<T>?, offset: Int, index: Int) {
        setFragmentBuffer(fragmentBuffer?.buffer, offset: offset, index: index)
    }
}
