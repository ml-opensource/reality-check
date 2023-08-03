import Dependencies
import Foundation
import Models
import MultipeerClient
import RealityKit
import SwiftUI
import StreamingClient

@available(visionOS 1.0, *)
@available(iOS, unavailable)
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@Observable
final public class RealityCheckConnectViewModel {
    var connectionState: MultipeerClient.SessionState
    var hostName: String
    var isStreaming = false
    
    var content: RealityViewContent!
    
    public init(
        connectionState: MultipeerClient.SessionState = .notConnected,
        hostName: String = "..."
    ) {
        self.connectionState = connectionState
        self.hostName = hostName
        Task {
            await startMultipeerSession()
        }
    }
    
    func startMultipeerSession() async {
        @Dependency(\.multipeerClient) var multipeerClient
        
        //MARK: 1. Setup
        for await action in await multipeerClient.start(
            serviceName: "reality-check",
            sessionType: .peer,
            discoveryInfo: AppInfo.discoveryInfo
        ) {
            switch action {
            case .session(let sessionAction):
                switch sessionAction {
                case .stateDidChange(let state):
                    await MainActor.run {
                        connectionState = state
                    }
                    if case .connected = state {
                        //MARK: 2. Send Hierarchy
                        // await sendHierarchy()
                    }
                    
                case .didReceiveData(let data):
                    //FIXME: display debug options
                    //ARView Debug Options
                    // if let debugOptions = try? JSONDecoder()
                    //   .decode(
                    //     _DebugOptions.self,
                    //     from: data
                    //   )
                    // {
                    //    await MainActor.run {
                    //      arView?.debugOptions = ARView.DebugOptions(
                    //        rawValue: debugOptions.rawValue
                    //      )
                    //    }
                    // }
                    return
                }
                
            case .browser(_):
                return
                
            case .advertiser(let advertiserAction):
                switch advertiserAction {
                case .didReceiveInvitationFromPeer(let peer):
                    multipeerClient.acceptInvitation()
                    multipeerClient.stopAdvertisingPeer()
                    await MainActor.run {
                        hostName = peer.displayName
                    }
                }
            }
        }
    }
    
    func sendHierarchy() async {
        @Dependency(\.multipeerClient) var multipeerClient
        @Dependency(\.realityDump) var realityDump
        
        let encoder = JSONEncoder()
        encoder.nonConformingFloatEncodingStrategy = .convertToString(
            positiveInfinity: "INF",
            negativeInfinity: "-INF",
            nan: "NAN"
        )
        encoder.outputFormatting = .prettyPrinted
        
        guard let root = content.root else { return }
        let identifiableEntity = await realityDump.identify(root)
        
        let realityViewData = try! encoder.encode(identifiableEntity)
        multipeerClient.send(realityViewData)
    }
    
    func startStreaming() async {
        @Dependency(\.multipeerClient) var multipeerClient
        @Dependency(\.streamingClient) var streamingClient
        
        await MainActor.run {
            isStreaming = true
        }
        
        for await frameData in await streamingClient.startScreenCapture() {
            multipeerClient.send(frameData)
        }
    }
    
    func stopStreaming() async {
        @Dependency(\.streamingClient) var streamingClient
        
        await MainActor.run {
            isStreaming = false
        }
        
        streamingClient.stopScreenCapture()
    }
}
