/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A renderer for rendering video.
*/

import CoreMedia
import Metal
import MetalKit

#if !os(xrOS)
  ///- Tag: Renderer
  class Renderer: NSObject {

    // Metal objects.
    let commandQueue: MTLCommandQueue

    let pipelineStates: PipelineStates
    let depthStencilStates: DepthStencilStates

    // A buffer that contains image plane vertex data.
    let imagePlaneVertexBuffer: BufferView<Float>

    var frames = [Frame]()
    let frameQueue = DispatchQueue(label: "frameQueue")

    // Video texture cache.
    let videoTextureCache: CVMetalTextureCache

    // The current viewport size.
    var viewportSize = CGSize()

    var lastDrawnPTS = CMTime.zero
    let maxFramesInQueue = 15

    init(
      device: MTLDevice,
      renderDestination: RenderDestination
    ) {

      imagePlaneVertexBuffer = BufferView<Float>(
        device: device,
        array: Constants.imagePlaneVertexData
      )

      pipelineStates = PipelineStates(device: device, renderDestination: renderDestination)
      depthStencilStates = DepthStencilStates(device: device)

      // Create video texture cache.
      var textureCache: CVMetalTextureCache!
      CVMetalTextureCacheCreate(nil, nil, device, nil, &textureCache)
      videoTextureCache = textureCache

      // Create the command queue.
      commandQueue = device.makeCommandQueue(maxCommandBufferCount: Constants.maxBuffersInFlight)!
    }

    /// Attempts to add a new frame to the queue of frames.
    /// If the new frame has a presentation time stamp that is earlier than the lastDrawnPTS, the system discards the frame.
    func enqueueFrame(
      pixelBuffer: CVPixelBuffer,
      presentationTimeStamp: CMTime
    ) {

      frameQueue.sync {

        /* Frames can back up in the queue due to network conditions.
             If the queue experiences significant backup, the system removes all frames from the queue so that it remains close to live. */
        if frames.count > maxFramesInQueue {
          frames.removeAll()
        }

        /* There is no purpose for frames that have an earlier presentation
             time than a previously drawn frame, so the system doesn’t add it to the queue of frames.*/
        guard presentationTimeStamp > lastDrawnPTS else { return }

        // Create two textures (Y and CbCr) from the provided imageBuffer
        if CVPixelBufferGetPlaneCount(pixelBuffer) < 2 { return }

        if let videoTextureY = createTexture(
          fromPixelBuffer: pixelBuffer,
          pixelFormat: .r8Unorm,
          planeIndex: 0
        ),
          let videoTextureCbCr = createTexture(
            fromPixelBuffer: pixelBuffer,
            pixelFormat: .rg8Unorm,
            planeIndex: 1
          )
        {
          let newFrame = Frame(
            textureY: videoTextureY,
            textureCbCr: videoTextureCbCr,
            presentationTimeStamp: presentationTimeStamp
          )

          // Insert the newFrame in newest to oldest order according to the presentationTimeStamps.
          if let index = frames.firstIndex(where: { (frame) -> Bool in
            frame.presentationTimeStamp < newFrame.presentationTimeStamp
          }) {
            frames.insert(newFrame, at: index)
          } else {
            frames.append(newFrame)
          }
        }
      }
    }

    private func createTexture(
      fromPixelBuffer pixelBuffer: CVPixelBuffer,
      pixelFormat: MTLPixelFormat,
      planeIndex: Int
    ) -> CVMetalTexture? {
      let width = CVPixelBufferGetWidthOfPlane(pixelBuffer, planeIndex)
      let height = CVPixelBufferGetHeightOfPlane(pixelBuffer, planeIndex)

      var texture: CVMetalTexture? = nil
      let status = CVMetalTextureCacheCreateTextureFromImage(
        nil,
        videoTextureCache,
        pixelBuffer,
        nil,
        pixelFormat,
        width,
        height,
        planeIndex,
        &texture
      )

      if status != kCVReturnSuccess {
        texture = nil
      }

      return texture
    }
  }

  // MARK: - MTKViewDelegate
  extension Renderer: MTKViewDelegate {

    // The system calls this whenever the view changes orientation or the layout changes.
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
      viewportSize = size
    }

    // The system calls this whenever the view needs to render.
    func draw(in view: MTKView) {

      // Only draw if there are available textures.
      frameQueue.sync {
        guard let frame = frames.popLast() else { return }

        guard let commandBuffer = commandQueue.makeCommandBuffer(),
          let renderPassDescriptor = view.currentRenderPassDescriptor
        else { return }

        commandBuffer.addCompletedHandler { _ in
          withExtendedLifetime(frame) {}
        }

        lastDrawnPTS = frame.presentationTimeStamp

        MetalUtils.encodePass(into: commandBuffer, using: renderPassDescriptor, label: "Main Pass")
        {
          renderEncoder in

          MetalUtils.encodeStage(using: renderEncoder, label: "Video Stream Stage") {
            // Set render command encoder state.
            renderEncoder.setCullMode(.none)
            renderEncoder.setRenderPipelineState(pipelineStates.videoStream)
            renderEncoder.setDepthStencilState(depthStencilStates.videoStream)

            // Set mesh's vertex buffers.
            renderEncoder.setVertexBuffer(
              imagePlaneVertexBuffer,
              offset: 0,
              index: BufferIndices.kBufferIndexMeshPositions.rawValue
            )

            // Set any textures that the render pipeline reads/samples.
            renderEncoder.setFragmentTexture(
              CVMetalTextureGetTexture(frame.textureY),
              index: TextureIndices.kTextureIndexY.rawValue
            )
            renderEncoder.setFragmentTexture(
              CVMetalTextureGetTexture(frame.textureCbCr),
              index: TextureIndices.kTextureIndexCbCr.rawValue
            )

            // Draw each submesh of the mesh.
            renderEncoder.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: 4)
          }
        }

        if let currentDrawable = view.currentDrawable {
          commandBuffer.present(currentDrawable)
        }

        commandBuffer.commit()
      }
    }
  }

  // MARK: - Constants
  extension Renderer {
    enum Constants {
      // The maximum number of command buffers in flight.
      static let maxBuffersInFlight: Int = 3

      // Vertex data for an image plane.
      static let imagePlaneVertexData: [Float] = [
        -1.0, -1.0, 0.0, 1.0,
        1.0, -1.0, 1.0, 1.0,
        -1.0, 1.0, 0.0, 0.0,
        1.0, 1.0, 1.0, 0.0,
      ]
    }
  }

  struct Frame {
    let textureY: CVMetalTexture
    let textureCbCr: CVMetalTexture
    let presentationTimeStamp: CMTime
  }
#endif
