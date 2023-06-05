import Dependencies
import Foundation

extension MultipeerClient {
  static public var testValue: Self = .init(
    start: { (_, _, _, _, _) in
      AsyncStream { continuation in
        let url = Bundle.module.url(forResource: "not_so_simple_arview", withExtension: "json")!
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
    send: { (_, _, _) in unimplemented("send") }
  )
}
