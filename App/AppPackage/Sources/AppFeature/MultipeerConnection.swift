import ComposableArchitecture
import Foundation
import Models
import MultipeerClient
import OSLog
import RealityCodable
import StreamingClient

public struct MultipeerConnection: Reducer {
  let logger = Logger(subsystem: "AppCore", category: "MultipeerConnection")

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
    case sendSelection(RealityPlatform.visionOS.Entity.ID)
    case start
    case updatePeers([Peer: DiscoveryInfo])
    case updateSessionState(MultipeerClient.SessionState)
  }

  public enum DelegateAction: Equatable {
    case didUpdateSessionState(MultipeerClient.SessionState)
    case peersUpdated
    case receivedDecodedARView(RealityPlatform.iOS.ARView)
    // case receivedDecodedEntities([RealityPlatform.visionOS.Entity])
    case receivedDecodedScene(RealityPlatform.visionOS.Scene)
    case receivedVideoFrameData(VideoFrameData)
    case receivedDump(String)
  }

  @Dependency(\.continuousClock) var clock
  @Dependency(\.multipeerClient) var multipeerClient

  public var body: some Reducer<State, Action> {
    Reduce<State, Action> { state, action in
      switch action {
        case .delegate(_):
          return .none

        case .invite(let peer):
          return .run { _ in
            await multipeerClient.invitePeer(peer)
          }

        case .sendDebugOptions(let options):
          do {
            let data = try JSONEncoder().encode(options)
            multipeerClient.send(data)
          } catch {
            fatalError("Failed to encode debug options while sending them.")
          }
          return .none

        case .sendSelection(let entityID):
          do {
            let entitySelection = EntitySelection(entityID)
            let data = try JSONEncoder().encode(entitySelection)
            multipeerClient.send(data)
          } catch {
            fatalError("Failed to encode selection while sending them.")
          }
          return .none

        case .start:
          guard state.connectedPeer == nil else { return .none }
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
                      guard !data.isEmpty else { return }
                      await self.decodeReceivedData(data, send: send)
                  }

                case .browser(let browserAction):
                  switch browserAction {
                    case .peersUpdated(let peers):
                      await send(.updatePeers(peers))
                      await send(.delegate(.peersUpdated))
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

    //MARK: VideoFrameData

    if let videoFrameData = try? defaultDecoder.decode(VideoFrameData.self, from: data) {
      await send(.delegate(.receivedVideoFrameData(videoFrameData)))
    }

    // MARK: Raw data

    else if let dumpData = try? defaultDecoder.decode(
      String.self,
      from: data
    ) {
      await send(.delegate(.receivedDump(dumpData)))
    }

    // MARK: ARView

    else if let decodedARView = try? defaultDecoder.decode(
      RealityPlatform.iOS.ARView.self,
      from: data
    ) {
      await send(.delegate(.receivedDecodedARView(decodedARView)))
    }

    // MARK: RealityViewContent

    else if let decodedRealityViewContentScene = try? defaultDecoder.decode(
      RealityPlatform.visionOS.Scene.self,
      from: data
    ) {
      // print(String(data: data, encoding: .utf8)!)
      await send(.delegate(.receivedDecodedScene(decodedRealityViewContentScene)))
    }

    // MARK: RealityViewContent Root
    // TODO: remove. This case should not happen as RealityViewContent should be wrapped on Scenes
    // else if let decodedRealityViewContent = try? defaultDecoder.decode(
    //   RealityPlatform.visionOS.Entity.self,
    //   from: data
    // ) {
    //   await send(.delegate(.receivedDecodedEntities([decodedRealityViewContent])))
    // }

    // MARK: - Unknown

    else {
      guard let decodedHierarchy = String(data: data, encoding: .utf8) else {
        fatalError("The received data cannot be decoded.")
      }
      // FIXME: avoid logger truncation
      // logger.debug(decodedHierarchy, privacy: .public)")
      print(decodedHierarchy)
      fatalError("Unrecognized or malformed hierarchy")
    }
  }
}
