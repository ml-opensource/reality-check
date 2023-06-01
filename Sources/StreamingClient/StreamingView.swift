import Dependencies
import MetalKit
import SwiftUI

#if os(macOS)
  public struct StreamingView: NSViewRepresentable {
    @Dependency(\.streamingClient) var streamingClient
    @Binding var viewportSize: CGSize

    private let metalView = MTKView()
    private var renderer: Renderer

    public init(
      viewportSize: Binding<CGSize>
    ) {
      guard let device = MTLCreateSystemDefaultDevice() else {
        fatalError("Unable to get system default device!")
      }
      renderer = Renderer(device: device, renderDestination: metalView)
      metalView.device = device
      metalView.delegate = renderer
      _viewportSize = viewportSize
    }

    public func makeNSView(context: Context) -> MTKView {
      startRendering()
      return metalView
    }

    public func updateNSView(_ mtKView: MTKView, context: Context) {
    }

    private func startRendering() {
      Task {
        for await sample in await streamingClient.nextSample() {
          renderer.enqueueFrame(
            pixelBuffer: sample.imageBuffer,
            presentationTimeStamp: sample.presentationTimeStamp
          )

          await MainActor.run {
            let width = CVPixelBufferGetWidth(sample.imageBuffer)
            let height = CVPixelBufferGetHeight(sample.imageBuffer)
            let viewportSize = CGSize(width: width, height: height)
            guard viewportSize != self.viewportSize else { return }
            self.viewportSize = viewportSize
          }
        }
      }
    }
  }

#endif
