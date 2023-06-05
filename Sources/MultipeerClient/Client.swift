import Dependencies
import Foundation
import MultipeerConnectivity

/// A client for MultipeerConnectivity that can be used as a dependency in a `@Dependency`.
public struct MultipeerClient {

  /// The session type for the Multipeer session.
  public enum SessionType: Int {
    case host = 1
    case peer = 2
    case both = 3
  }

  /// The connection state for the Multipeer session.
  public enum SessionState: Int {
    case notConnected
    case connecting
    case connected
  }

  public enum Action: Equatable {
    case session(SessionAction)
    case browser(BrowserAction)
    case advertiser(AdvertiserAction)

    public enum SessionAction: Equatable {
      case stateDidChange(SessionState)
      case didReceiveData(Data)
    }

    public enum BrowserAction: Equatable {
      case peersUpdated([Peer: DiscoveryInfo])
    }

    public enum AdvertiserAction: Equatable {
      case didReceiveInvitationFromPeer(Peer)
    }
  }

  /// The internal closure that sets up the Multipeer session.
  public var start:
    (String, SessionType, String?, DiscoveryInfo?, MCEncryptionPreference) async -> AsyncStream<
      Action
    >

  /**
    Sets up the Multipeer session.

    - Parameters:
       - serviceName: The service name for the Multipeer session.
       - sessionType: The session type for the Multipeer session. Default is `.both`.
       - peerName: The name of the local peer. If `nil`, the device name is used.
       - discoveryInfo: A dictionary of key-value pairs that are made available to browsers.
       - encryptionPreference: The encryption preference for the Multipeer session. Default is `.required`.

    - Returns: An `AsyncStream<Action>` that emits `Action` objects.

    This function sets up the Multipeer session with the specified parameters.
    */
  public func start(
    serviceName: String,
    sessionType: SessionType = .both,
    peerName: String? = nil,
    discoveryInfo: DiscoveryInfo? = nil,
    encryptionPreference: MCEncryptionPreference = .required
  ) async -> AsyncStream<Action> {
    await self.start(serviceName, sessionType, peerName, discoveryInfo, encryptionPreference)
  }

  /**
  Returns an `AsyncStream` that emits `Peer` objects when a remote peer sends an invitation to connect.

  - Returns: An `AsyncStream<Peer>` that emits `Peer` objects.

  This function starts advertising the local device as a peer and returns an `AsyncStream` that emits `Peer` objects when a remote peer sends an invitation to connect.
  */
  public var startAdvertisingPeer: () -> Void

  /**
  Stops advertising the local device as a peer.

  This function stops advertising the local device as a peer and disconnects from all peers.
  */
  public var stopAdvertisingPeer: () -> Void

  /**
  Returns an `AsyncStream` that emits an array of `Peer` objects when a new peer is found or lost.

  - Returns: An `AsyncStream<[Peer]>` that emits an array of `Peer` objects.

  This function starts browsing for remote peers and returns an `AsyncStream` that emits an array of `Peer` objects when a new peer is found or lost.
  */
  public var startBrowsingForPeers: () -> Void

  /**
  Stops browsing for remote peers.

  This function stops browsing for remote peers and disconnects from all peers.
  */
  public var stopBrowsingForPeers: () -> Void

  /**
  Invites a remote peer to connect.

  - Parameters:
      - peer: The `Peer` object representing the remote peer to invite.

  This function invites the specified remote peer to connect to the local device.
  */
  public var invitePeer: (Peer) -> Void

  // FIXME: consider throwing for those not so ideal cases
  /**
  Accepts an invitation from a remote peer.

  - Throws: An error if the invitation cannot be accepted.

  This function accepts an invitation from a remote peer to connect to the local device.
  */
  public var acceptInvitation: () -> Void

  // FIXME: consider throwing for those not so ideal cases
  /**
  Rejects an invitation from a remote peer.

  - Throws: An error if the invitation cannot be rejected.

  This function rejects an invitation from a remote peer to connect to the local device.
  */
  public var rejectInvitation: () -> Void

  /// The internal closure that sends data to a list of peers.
  var send: (Data, [Peer], MCSessionSendDataMode) -> Void

  /**
  Sends data to a list of peers using a specific send mode.

  - Parameters:
      - data: The data to send.
      - peers: An array of `Peer` objects representing the destination peers. If no peers are specified, the connected peers in the current session will be used.
      - mode: Indicates whether delivery of data should be guaranteed.

  Use this method to send data to a list of peers. The `data` parameter contains the data to send, while the `peers` parameter is an array of `Peer` objects representing the destination peers. The `mode` parameter specifies the send mode to use.
  */
  public func send(
    _ data: Data,
    toPeers peers: [Peer] = [],
    with mode: MCSessionSendDataMode = .reliable
  ) {
    self.send(data, peers, mode)
  }
}

/// An extension of `DependencyValues` that adds a `multipeerClient` property.
extension DependencyValues {

  /**
  The `MultipeerClient` dependency.

  - Returns: A `MultipeerClient` instance.

  Use this property to access the `MultipeerClient` instance for your app.
  */
  public var multipeerClient: MultipeerClient {
    get { self[MultipeerClient.self] }
    set { self[MultipeerClient.self] = newValue }
  }
}
