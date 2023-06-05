import Dependencies
import Foundation
import ReplayKit

extension StreamingClient: DependencyKey {
  static public var liveValue: Self = .init(
    startScreenCapture: {
      await StreamingActor.shared.startCapture()
    },
    stopScreenCapture: {
      Task {
        await StreamingActor.shared.stopCapture()
      }
    },
    prepareForRender: { videoFrameData in
      Task {
        await StreamingActor.shared.prepareForRender(
          videoFrameData: videoFrameData
        )
      }
    },
    nextSample: {
      await StreamingActor.shared.nextSample()
    }
  )
}

//MARK: - Streaming Actor

extension StreamingClient {
  final actor StreamingActor: GlobalActor {
    static let shared = StreamingActor()

    private let screenRecorder = RPScreenRecorder.shared()
    private let videoProcessor = VideoProcessor()
    private var sampleContinuation: AsyncStream<Sample>.Continuation?

    func startCapture() async -> AsyncStream<Data> {
      AsyncStream { continuation in
        //FIXME: Explore async API version.
        screenRecorder.startCapture(
          handler: { (sampleBuffer, type, error) in
            //TODO: Make stream throwable.
            // guard error == nil else { continuation.throw }
            self.videoProcessor.compressAndSend(sampleBuffer) {
              data in
              continuation.yield(data)
            }
          },
          completionHandler: { _ in
            //TODO: Handle completion.
          }
        )
      }
    }

    func stopCapture() {
      screenRecorder.stopCapture()
    }

    func prepareForRender(videoFrameData: VideoFrameData) {
      let sampleBuffer = videoFrameData.makeSampleBuffer()
      videoProcessor.decompress(sampleBuffer) {
        (imageBuffer, presentationTimeStamp) in
        self.sampleContinuation?
          .yield(
            Sample(
              imageBuffer: imageBuffer,
              presentationTimeStamp: presentationTimeStamp
            )
          )
      }
    }

    func nextSample() async -> AsyncStream<Sample> {
      let stream = AsyncStream<Sample> {
        sampleContinuation = $0
      }
      return stream
    }
  }
}
