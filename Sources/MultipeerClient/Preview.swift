import Foundation

extension MultipeerClient {
  static public var previewValue: Self = .init(
    start: { (_, _, _, _, _) in
      AsyncStream { continuation in
        continuation.yield(.session(.stateDidChange(.connected)))
        continuation.finish()
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
