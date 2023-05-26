import Foundation

extension MultipeerClient {
    static public var previewValue: Self = .init(
        start: { (_, _, _, _, _) in
            AsyncStream { continuation in
                let url = Bundle.module.url(forResource: "not_so_simple_arview", withExtension: "json")!
                let data = try! Data(contentsOf: url)
                continuation.yield(.session(.stateDidChange(.connected)))
                continuation.yield(.session(.didReceiveData(data)))
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
