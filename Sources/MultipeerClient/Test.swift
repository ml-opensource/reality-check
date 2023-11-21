import Dependencies
import Foundation

extension MultipeerClient {
  static public var testValue: Self = .init(
    start: { (_, _, _) in
      AsyncStream { continuation in
        let mocky = Peer(displayName: "MOCKY")
        let mockyDiscoveryInfo = DiscoveryInfo(
          appName: "MockyAppName",
          appVersion: "0.4.2",
          device: "Vision Mock",
          system: "visionOS 1.0"
        )
        continuation.yield(.browser(.peersUpdated([mocky: mockyDiscoveryInfo])))
        continuation.yield(.session(.stateDidChange(.connected(mocky))))

        let url = Bundle.module.url(
          forResource: "basic_visionOS",
          withExtension: "json",
          subdirectory: "Mock"
        )!

        let data = try! Data(contentsOf: url)
        continuation.yield(.session(.didReceiveData(data)))
      }
    },
    startAdvertisingPeer: { unimplemented("startAdvertisingPeer") },
    stopAdvertisingPeer: { unimplemented("stopAdvertisingPeer") },
    startBrowsingForPeers: { unimplemented("startBrowsingForPeers") },
    stopBrowsingForPeers: { unimplemented("stopBrowsingForPeers") },
    invitePeer: { _ in unimplemented("invitePeer") },
    acceptInvitation: { unimplemented("acceptInvitation") },
    rejectInvitation: { unimplemented("rejectInvitation") },
    send: { _ in unimplemented("send") },
    disconnect: { unimplemented("disconnect") }
  )
}
