import ComposableArchitecture
import Foundation
import MultipeerClient
import StreamingClient

public struct MultipeerConnection: Reducer {
  public struct State: Equatable {
    public var sessionState: MultipeerClient.SessionState = .notConnected
    public var peers: [Peer] = []
  }

  public enum Action: Equatable {
    case delegate(DelegateAction)
    case invite(Peer)
    case start
    case updatePeers([Peer])
    case updateSessionState(MultipeerClient.SessionState)
  }

  public enum DelegateAction: Equatable {
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

        case .start:
        return .run(priority: .userInitiated) { send in
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
                      if let videoFrameData = try? JSONDecoder()
                        .decode(VideoFrameData.self, from: data)
                      {
                        await send(.delegate(.receivedVideoFrameData(videoFrameData)))
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
          return .none
      }
    }
  }
}
