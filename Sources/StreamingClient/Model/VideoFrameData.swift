/*
See LICENSE folder for this sample’s licensing information.

Abstract:
VideoFrameData contains the essential data from a CMSampleBuffer in a form that you can easily serialize for sending over a network.
*/

import CoreMedia

public struct VideoFrameData: Codable {

  // let inverseProjectionMatrix: Matrix
  // let inverseViewMatrix: Matrix

  init(sampleBuffer: CMSampleBuffer) {
    if let formatDescription = sampleBuffer.formatDescription {
      parameterSets = formatDescription.parameterSets.map { Data($0) }
    }

    // Copy buffer data to the output.
    if let dataBuffer = sampleBuffer.dataBuffer {
      do {
        bufferData = try dataBuffer.withUnsafeMutableBytes { Data($0) }
      } catch {
        fatalError("Failed to get bytes from dataBuffer with error: \(error.localizedDescription)")
      }
    }

    // Copy sample timings to the output.
    sampleCount = sampleBuffer.numSamples

    do {
      sampleSizes = try sampleBuffer.sampleSizes()
      sampleTimings = try sampleBuffer.sampleTimingInfos().map { VideoFrameData.TimingInfo($0) }
    } catch {
      fatalError(
        "Failed to get timing info from sample buffer with error: \(error.localizedDescription)")
    }

    // let camera = arFrame.camera
    // let width = CVPixelBufferGetWidth(arFrame.capturedImage)
    // let height = CVPixelBufferGetHeight(arFrame.capturedImage)
    // let viewportSize = CGSize(width: width, height: height)
    // inverseProjectionMatrix = Matrix(camera.projectionMatrix(for: .landscapeRight, viewportSize: viewportSize, zNear: 0.01, zFar: 1000).inverse)
    // inverseViewMatrix = Matrix(camera.viewMatrix(for: .landscapeRight).inverse)
  }

  /// Explicit representation of a `CMTime` value.
  struct TimeStamp: Codable {

    var timeEpoch: CMTimeEpoch
    var timeValue: CMTimeValue
    var timeScale: CMTimeScale
    var timeFlags: CMTimeFlags.RawValue

    /// Initializes to default values.
    init() {
      timeEpoch = 0
      timeValue = 0
      timeScale = 0
      timeFlags = 0
    }

    /// Initialize from a `CMTime` value.
    init(_ time: CMTime) {
      timeEpoch = time.epoch
      timeValue = time.value
      timeScale = time.timescale
      timeFlags = time.flags.rawValue
    }

    /// Converts back to a `CMTime` value.
    var time: CMTime {
      CMTime(
        value: timeValue, timescale: timeScale, flags: CMTimeFlags(rawValue: timeFlags),
        epoch: timeEpoch)
    }
  }

  /// Explicit representation of a `CMSampleTimingInfo` value.
  struct TimingInfo: Codable {

    var duration = TimeStamp()
    var pts = TimeStamp()
    var dts = TimeStamp()

    /// Initializes from a `CMSampleTimingInfo` value.
    init(_ timingInfo: CMSampleTimingInfo) {
      duration = TimeStamp(timingInfo.duration)
      pts = TimeStamp(timingInfo.presentationTimeStamp)
      dts = TimeStamp(timingInfo.decodeTimeStamp)
    }

    /// Converts back to a `CMSampleTimingInfo` value.
    var timingInfo: CMSampleTimingInfo {
      CMSampleTimingInfo(
        duration: duration.time, presentationTimeStamp: pts.time, decodeTimeStamp: dts.time)
    }
  }

  /// Extracted information from a `CMSampleBuffer`.
  var parameterSets: [Data] = []
  var bufferData: Data!
  var sampleCount: Int = 0
  var sampleSizes: [Int] = []
  var sampleTimings: [TimingInfo] = []

  /// Makes a CMSampleBuffer from the VideoFrameData.
  func makeSampleBuffer() -> CMSampleBuffer {
    // Create a format description from the parameter sets.
    do {
      let formatDescription = try CMFormatDescription(hevcParameterSets: parameterSets)

      // Get the buffer data.
      let blockBuffer = try CMBlockBuffer(length: bufferData.count)

      bufferData.withUnsafeBytes { ptr in
        try? blockBuffer.replaceDataBytes(with: ptr)
      }

      // Create a sample buffer.
      let sampleBuffer = try CMSampleBuffer(
        dataBuffer: blockBuffer,
        formatDescription: formatDescription,
        numSamples: sampleCount,
        sampleTimings: sampleTimings.map { $0.timingInfo },
        sampleSizes: sampleSizes)

      return sampleBuffer
    } catch {
      fatalError("Failed to create sample buffer with error: \(error.localizedDescription)")
    }
  }

}
