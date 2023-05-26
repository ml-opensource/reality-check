import ComposableArchitecture
import Foundation
import Models
import MultipeerClient
import StreamingClient

public struct MultipeerConnection: Reducer {
  public struct State: Equatable {
    public var sessionState: MultipeerClient.SessionState
    public var peers: [Peer: DiscoveryInfo]

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
    case receivedVideoFrameData(VideoFrameData)
  }

  @Dependency(\.multipeerClient) var multipeerClient

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
          return .run(priority: .userInitiated) { send in
            for await action in await multipeerClient.start(
              serviceName: "reality-check",
              sessionType: .host
            ) {
              let decoder = JSONDecoder()
              decoder.nonConformingFloatDecodingStrategy = .convertFromString(
                positiveInfinity: "INF",
                negativeInfinity: "-INF",
                nan: "NAN"
              )

              switch action {
                case .session(let sessionAction):
                  switch sessionAction {
                    case .stateDidChange(let sessionState):
                      await send(.updateSessionState(sessionState))

                    case .didReceiveData(let data):
                      guard !data.isEmpty else { return }

                      //MARK: VideoFrameData
                      if let videoFrameData = try? decoder.decode(VideoFrameData.self, from: data) {
                        await send(.delegate(.receivedVideoFrameData(videoFrameData)))

                      }  //MARK: CodableARView
                      else if let decodedARView = try? decoder.decode(
                        CodableARView.self,
                        from: data
                      ) {
                        await send(.delegate(.receivedDecodedARView(decodedARView)))
                      } else {
                        fatalError(String(data: data, encoding: .utf8)!)
                      }
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

        case .updatePeers(let peers):
          state.peers = peers
          return .none

        case .updateSessionState(let sessionState):
          state.sessionState = sessionState
          return .task {
            .delegate(.didUpdateSessionState(sessionState))
          }
      }
    }
  }
}
