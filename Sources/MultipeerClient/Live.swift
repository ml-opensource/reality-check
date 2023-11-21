import Dependencies
import Foundation
import MultipeerConnectivity

extension MultipeerClient: DependencyKey {
  static public var liveValue: Self = .init(
    start: { (serviceName, sessionType, discoveryInfo) in
      let name: String

      #if os(iOS) || os(tvOS) || os(visionOS)
        name = await UIDevice.current.name
      #elseif os(macOS)
        name = Host.current().name ?? UUID().uuidString
      #endif

      return await MultipeerActor.shared.start(
        serviceName: serviceName,
        sessionType: sessionType,
        peerName: name,
        discoveryInfo: discoveryInfo?.rawValue,
        encryptionPreference: .required
      )
    },
    startAdvertisingPeer: {
      await MultipeerActor.shared.startAdvertisingPeer()
    },
    stopAdvertisingPeer: {
      await MultipeerActor.shared.stopAdvertisingPeer()
    },
    startBrowsingForPeers: {
      await MultipeerActor.shared.startBrowsingForPeers()
    },
    stopBrowsingForPeers: {
      await MultipeerActor.shared.stopBrowsingForPeers()
    },
    invitePeer: { peer in
      await MultipeerActor.shared.invitePeer(peer.rawValue)
    },
    acceptInvitation: {
      await MultipeerActor.shared.acceptInvitation()
    },
    rejectInvitation: {
      await MultipeerActor.shared.rejectInvitation()
    },
    send: { data in
      await MultipeerActor.shared.send(data)
    },
    disconnect: {
      await MultipeerActor.shared.disconnect()
    }
  )
}

//MARK: - Multipeer Actor

extension MultipeerClient {
  final actor MultipeerActor: GlobalActor {
    static let shared = MultipeerActor()

    private var session: MCSession!
    private let sessionDelegate = SessionDelegate()
    private var serviceBrowser: MCNearbyServiceBrowser?
    private var serviceBrowserDelegate: ServiceBrowserDelegate?
    private var serviceAdvertiser: MCNearbyServiceAdvertiser?
    private var serviceAdvertiserDelegate: ServiceAdvertiserDelegate?

    func start(
      serviceName: String,
      sessionType: MultipeerClient.SessionType,
      peerName: String,
      discoveryInfo: [String: String]?,
      encryptionPreference: MCEncryptionPreference
    ) -> AsyncStream<Action> {
      AsyncStream { continuation in
        let myPeerID = MCPeerID(displayName: peerName)
        setupSession()

        switch sessionType {
          case .host:
            setupServiceBrowser()

          case .peer:
            setupServiceAdvertiser()

          case .both:
            setupServiceBrowser()
            setupServiceAdvertiser()
        }

        //MARK: Session

        func setupSession() {
          session = MCSession(
            peer: myPeerID,
            securityIdentity: nil,
            encryptionPreference: encryptionPreference
          )
          session?.delegate = sessionDelegate
          sessionDelegate.continuation = continuation
        }

        //MARK: Browser

        func setupServiceBrowser() {
          serviceBrowser = MCNearbyServiceBrowser(
            peer: myPeerID,
            serviceType: serviceName
          )
          serviceBrowserDelegate = ServiceBrowserDelegate()
          serviceBrowserDelegate?.continuation = continuation
          serviceBrowser?.delegate = serviceBrowserDelegate
          serviceBrowser?.startBrowsingForPeers()
        }

        //MARK: Advertiser

        func setupServiceAdvertiser() {
          serviceAdvertiser = MCNearbyServiceAdvertiser(
            peer: myPeerID,
            discoveryInfo: discoveryInfo,
            serviceType: serviceName
          )
          serviceAdvertiserDelegate = ServiceAdvertiserDelegate()
          serviceAdvertiserDelegate?.continuation = continuation
          serviceAdvertiser?.delegate = serviceAdvertiserDelegate
          startAdvertisingPeer()
        }
      }
    }
  }
}

//MARK: Actions
extension MultipeerClient.MultipeerActor {

  //MARK: Browsing

  func startBrowsingForPeers() {
    serviceBrowser?.startBrowsingForPeers()
  }

  func stopBrowsingForPeers() {
    serviceBrowser?.stopBrowsingForPeers()
  }

  //MARK: Advertising

  func startAdvertisingPeer() {
    serviceAdvertiser?.startAdvertisingPeer()
  }

  func stopAdvertisingPeer() {
    serviceAdvertiser?.stopAdvertisingPeer()
  }

  //MARK: Invite

  func invitePeer(_ peerID: MCPeerID) {
    serviceBrowser?
      .invitePeer(
        peerID,
        to: session,
        withContext: nil,
        timeout: 120
      )
  }

  func acceptInvitation() {
    serviceAdvertiserDelegate?.acceptInvitation(session)
  }

  func rejectInvitation() {
    serviceAdvertiserDelegate?.rejectInvitation(session)
  }

  //MARK: Connection

  func disconnect() {
    session.disconnect()
  }

  //MARK: Data transmission

  func send(
    _ data: Data,
    with mode: MCSessionSendDataMode = .reliable
  ) {
    do {
      guard let connectedPeers = session?.connectedPeers else {
        fatalError(
          "There are no connected peers and no specified peers to send to."
        )
      }
      try session?.send(data, toPeers: connectedPeers, with: mode)
    } catch {
      //TODO: handle errors
      //fatalError("Failed to send data.")
      print("Failed to send data.")
    }
  }
}

//MARK: Session Delegate

extension MultipeerClient.MultipeerActor {
  final class SessionDelegate: NSObject, MCSessionDelegate {
    var continuation: AsyncStream<MultipeerClient.Action>.Continuation?

    func session(
      _ session: MCSession,
      peer peerID: MCPeerID,
      didChange state: MCSessionState
    ) {
      let sessionState: MultipeerClient.SessionState

      switch state {
        case .notConnected:
          sessionState = .notConnected
        case .connecting:
          sessionState = .connecting(Peer.init(rawValue: peerID))
        case .connected:
          sessionState = .connected(Peer.init(rawValue: peerID))

        @unknown default:
          fatalError("MCSessionState: @unknown")
      }
      continuation?.yield(.session(.stateDidChange(sessionState)))
    }

    func session(
      _ session: MCSession,
      didReceive data: Data,
      fromPeer peerID: MCPeerID
    ) {
      continuation?.yield(.session(.didReceiveData(data)))
    }

    func session(
      _ session: MCSession,
      didStartReceivingResourceWithName resourceName: String,
      fromPeer peerID: MCPeerID,
      with progress: Progress
    ) {
      //TODO:
    }

    func session(
      _ session: MCSession,
      didFinishReceivingResourceWithName resourceName: String,
      fromPeer peerID: MCPeerID,
      at localURL: URL?,
      withError error: Error?
    ) {
      //TODO:
    }

    func session(
      _ session: MCSession,
      didReceive stream: InputStream,
      withName streamName: String,
      fromPeer peerID: MCPeerID
    ) {
      //TODO
    }
  }
}

//MARK: Service Browser Delegate

extension MultipeerClient.MultipeerActor {
  final class ServiceBrowserDelegate: NSObject, MCNearbyServiceBrowserDelegate {
    var continuation: AsyncStream<MultipeerClient.Action>.Continuation?
    private var peers: [Peer: DiscoveryInfo] = [:]

    func browser(
      _ browser: MCNearbyServiceBrowser,
      foundPeer peerID: MCPeerID,
      withDiscoveryInfo info: [String: String]?
    ) {

      peers[Peer.init(rawValue: peerID)] = DiscoveryInfo(rawValue: info)
      continuation?.yield(.browser(.peersUpdated(peers)))
    }

    func browser(
      _ browser: MCNearbyServiceBrowser,
      lostPeer peerID: MCPeerID
    ) {
      peers.removeValue(forKey: Peer.init(rawValue: peerID))
      continuation?.yield(.browser(.peersUpdated(peers)))
    }
  }
}

//MARK: Service Advertiser Delegate

extension MultipeerClient.MultipeerActor {
  final class ServiceAdvertiserDelegate: NSObject, MCNearbyServiceAdvertiserDelegate {
    typealias InvitationHandler = (Bool, MCSession?) -> Void

    var continuation: AsyncStream<MultipeerClient.Action>.Continuation?
    private var invitationHandler: InvitationHandler?

    func advertiser(
      _ advertiser: MCNearbyServiceAdvertiser,
      didReceiveInvitationFromPeer peerID: MCPeerID,
      withContext context: Data?,
      invitationHandler: @escaping InvitationHandler
    ) {
      self.invitationHandler = invitationHandler
      continuation?
        .yield(
          .advertiser(.didReceiveInvitationFromPeer(Peer(rawValue: peerID)))
        )
    }

    func acceptInvitation(_ session: MCSession) {
      guard let invitationHandler else {
        fatalError("No invitation found to accept.")
      }
      invitationHandler(true, session)
    }

    func rejectInvitation(_ session: MCSession) {
      guard let invitationHandler else {
        fatalError("No invitation found to reject.")
      }
      invitationHandler(false, session)
    }
  }
}
