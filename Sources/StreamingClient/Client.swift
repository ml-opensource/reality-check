import Dependencies
import Foundation

/// A client for streaming screen capture data and preparing it for rendering.
public struct StreamingClient {

	/// Starts streaming screen capture data.
	///
	/// - Returns: An `AsyncStream` of `Data` representing the screen capture frames.
	public var startScreenCapture: () async -> AsyncStream<Data>

	/// Prepares the screen capture data for rendering.
	///
	/// - Parameter frameData: The `VideoFrameData` to prepare.
	public var prepareForRender: (VideoFrameData) -> Void

	/// Retrieves the next sample for rendering.
	///
	/// - Returns: An `AsyncStream` of `Sample` representing the prepared samples for rendering.
	public var nextSample: () async -> AsyncStream<Sample>
}

/// An extension of `DependencyValues` that adds a `streamingClient` property.
extension DependencyValues {

	/// The `StreamingClient` dependency.
	public var streamingClient: StreamingClient {
		get { self[StreamingClient.self] }
		set { self[StreamingClient.self] = newValue }
	}
}
