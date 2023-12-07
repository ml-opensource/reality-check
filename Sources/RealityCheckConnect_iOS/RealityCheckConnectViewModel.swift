import Dependencies
import Models
import MultipeerClient
import RealityCodable
import RealityDump
import RealityKit
import StreamingClient
import SwiftUI

@MainActor
final class RealityCheckConnectViewModel: ObservableObject {
  @Published var connectionState: MultipeerClient.SessionState
  @Published var hostName: String
  @Published var isStreaming = false
  var selectedEntityID: UInt64?

  @Dependency(\.multipeerClient) var multipeerClient
  @Dependency(\.streamingClient) var streamingClient

  weak var arView: ARView?
  private var selectionEntity = ModelEntity(
    mesh: .generateSphere(radius: 0.075),
    materials: [UnlitMaterial(color: .systemPink)]
  )

  init(
    connectionState: MultipeerClient.SessionState = .notConnected,
    hostName: String = "[REDACTED]",
    arView: ARView? = nil
  ) {
    self.connectionState = connectionState
    self.hostName = hostName
    self.arView = arView
    Task {
      try await startMultipeerSession()
    }
  }
}
