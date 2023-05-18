import Dependencies
import MetalKit
import SwiftUI

public struct MetalViewRepresentable: NSViewRepresentable {
	@Dependency(\.streamingClient) var streamingClient

	private let metalView = MTKView()
	private var renderer: Renderer

	public init() {
		guard let device = MTLCreateSystemDefaultDevice() else {
			fatalError("Unable to get system default device!")
		}
		renderer = Renderer(device: device, renderDestination: metalView)
		metalView.device = device
		metalView.delegate = renderer
	}

	public func makeNSView(context: Context) -> MTKView {
		startRendering()
		return metalView
	}

	public func updateNSView(_ nsView: MTKView, context: Context) {
	}

	private func startRendering() {
		Task {
			for await sample in await streamingClient.nextSample() {
				renderer.enqueueFrame(
					pixelBuffer: sample.imageBuffer,
					presentationTimeStamp: sample.presentationTimeStamp
				)
			}
		}
	}
}
