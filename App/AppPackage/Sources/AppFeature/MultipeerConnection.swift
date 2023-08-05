import ComposableArchitecture
import Foundation
import Models
import MultipeerClient
import StreamingClient

public struct MultipeerConnection: Reducer {
  public struct ConnectedPeer: Equatable {
    public let peer: Peer
    public let discoveryInfo: DiscoveryInfo?
  }

  public struct State: Equatable {
    public var sessionState: MultipeerClient.SessionState
    public var peers: [Peer: DiscoveryInfo]
    public var connectedPeer: ConnectedPeer?

    public init(
      sessionState: MultipeerClient.SessionState = .notConnected,
      peers: [Peer: DiscoveryInfo] = [:]
    ) {
      self.sessionState = sessionState
      self.peers = peers
    }
  }

  public enum Action: Equatable {
    case delegate(DelegateAction)
    case invite(Peer)
    case sendDebugOptions(_DebugOptions)
    case start
    case updatePeers([Peer: DiscoveryInfo])
    case updateSessionState(MultipeerClient.SessionState)
  }

  public enum DelegateAction: Equatable {
    case didUpdateSessionState(MultipeerClient.SessionState)
    case receivedDecodedARView(CodableARView)
    case receivedDecodedEntities([IdentifiableEntity])
    case receivedVideoFrameData(VideoFrameData)
  }

  @Dependency(\.continuousClock) var clock
  @Dependency(\.multipeerClient) var multipeerClient
  private enum CancelID { case start }

  public var body: some Reducer<State, Action> {
    Reduce<State, Action> { state, action in
      switch action {
        case .delegate(_):
          return .none

        case .invite(let peer):
          multipeerClient.invitePeer(peer)
          return .none

        case .sendDebugOptions(let options):
          do {
            let data = try JSONEncoder().encode(options)
            multipeerClient.send(data)
          } catch {
            fatalError("Failed to encode debug options while sending them.")
          }
          return .none

        case .start:
          return
            .run { send in
              try await self.clock.sleep(for: .seconds(1))  //FIXME: Why a delay is needed?, perhaps try to avoid multi-calling.
              for await action in await multipeerClient.start(
                serviceName: "reality-check",
                sessionType: .host
              ) {
                switch action {
                  case .session(let sessionAction):
                    switch sessionAction {
                      case .stateDidChange(let sessionState):
                        await send(.updateSessionState(sessionState))

                      case .didReceiveData(let data):
                        guard !data.isEmpty else { return }
                        await self.decodeReceivedData(data, send: send)
                    }

                  case .browser(let browserAction):
                    switch browserAction {
                      case .peersUpdated(let peers):
                        await send(.updatePeers(peers))
                    }

                  case .advertiser(_):
                    return
                }
              }
            }
            .cancellable(id: CancelID.start, cancelInFlight: true)

        case .updatePeers(let peers):
          state.peers = peers
          return .none

        case .updateSessionState(let sessionState):
          state.sessionState = sessionState
          switch sessionState {
            case .notConnected:
              state.connectedPeer = nil
            case .connecting(_):
              break
            case .connected(let peer):
              state.connectedPeer = .init(peer: peer, discoveryInfo: state.peers[peer])
          }
          return .send(.delegate(.didUpdateSessionState(sessionState)))
      }
    }
  }
}

extension MultipeerConnection {
  fileprivate func decodeReceivedData(_ data: Data, send: Send<MultipeerConnection.Action>) async {
    let decoder = JSONDecoder()
    decoder.nonConformingFloatDecodingStrategy = .convertFromString(
      positiveInfinity: "INF",
      negativeInfinity: "-INF",
      nan: "NAN"
    )

    //MARK: VideoFrameData
    if let videoFrameData = try? decoder.decode(VideoFrameData.self, from: data) {
      await send(.delegate(.receivedVideoFrameData(videoFrameData)))
    }
    //MARK: CodableARView
    else if let decodedARView = try? decoder.decode(
      CodableARView.self,
      from: data
    ) {
      print(String(data: data, encoding: .utf8)!)
      await send(.delegate(.receivedDecodedARView(decodedARView)))
    }
    //MARK: RealityViewContent Root
    else if let decodedRealityViewContent = try? decoder.decode(
      IdentifiableEntity.self,
      from: data
    ) {
      await send(.delegate(.receivedDecodedEntities([decodedRealityViewContent])))
    }
    //MARK: default
    else {
      fatalError(String(data: data, encoding: .utf8)!)
    }
  }
}
