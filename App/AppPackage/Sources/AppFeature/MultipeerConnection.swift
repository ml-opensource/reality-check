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
    case start
    case updatePeers([Peer: DiscoveryInfo])
    case updateSessionState(MultipeerClient.SessionState)
  }

  public enum DelegateAction: Equatable {
    case didUpdateSessionState(MultipeerClient.SessionState)
    case receivedVideoFrameData(VideoFrameData)
    case receivedVideoHierarchyData([IdentifiableEntity])
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
              let someDecoder = JSONDecoder()
              someDecoder.nonConformingFloatDecodingStrategy = .convertFromString(
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
                      if let videoFrameData = try? JSONDecoder()
                        .decode(VideoFrameData.self, from: data)
                      {
                        await send(.delegate(.receivedVideoFrameData(videoFrameData)))
                      } else if let hierarchyData = try? someDecoder.decode(
                        [IdentifiableEntity].self,
                        from: data
                      ) {
                        await send(
                          .delegate(.receivedVideoHierarchyData(hierarchyData))
                        )
                      } else {
                        fatalError()
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
