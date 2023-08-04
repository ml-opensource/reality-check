import Foundation

public protocol RealityCheckConnectable {
  func startMultipeerSession() async -> Void
  func sendMultipeerData() async -> Void
  func startVideoStreaming() async -> Void
  func stopVideoStreaming() async -> Void
}
