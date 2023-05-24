import Foundation

extension MultipeerClient {
  static public var testValue: Self = .init(
    start: { (_, _, _, _, _) in
      AsyncStream { continuation in
        let data = Data()
        continuation.yield(.session(.didReceiveData(data)))
      }
    },
    startAdvertisingPeer: {},
    stopAdvertisingPeer: {},
    startBrowsingForPeers: {},
    stopBrowsingForPeers: {},
    invitePeer: { _ in },
    acceptInvitation: {},
    rejectInvitation: {},
    send: { (_, _, _) in }
  )
}
