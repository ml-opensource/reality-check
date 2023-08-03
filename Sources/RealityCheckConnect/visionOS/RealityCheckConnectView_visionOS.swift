import Dependencies
import Models
import MultipeerClient
import RealityDumpClient
import RealityKit
import StreamingClient
import SwiftUI

#if os(xrOS)
    extension RealityViewContent {
        var root: Entity? {
            guard let firstEntity = self.entities.first else { return nil }
            return climbToRoot(from: firstEntity)
        }

        private func climbToRoot(from entity: Entity) -> Entity {
            if let parent = entity.parent {
                return climbToRoot(from: parent)
            } else {
                return entity
            }
        }
    }

    final public class _ViewModel: ObservableObject {
        @Published var connectionState: MultipeerClient.SessionState
        @Published var hostName: String
        @Published var isStreaming = false

        @Dependency(\.multipeerClient) var multipeerClient
        @Dependency(\.realityDump) var realityDump
        @Dependency(\.streamingClient) var streamingClient

        var content: RealityViewContent!

        public init(
            connectionState: MultipeerClient.SessionState = .notConnected,
            hostName: String = "..."
        ) {
            self.connectionState = connectionState
            self.hostName = hostName
        }

        public func startSession() {
            Task {
                await startMultipeerSession()
            }
        }

        public func startMultipeerSession() async {
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
//                            await sendHierarchy()
                        }

                    case .didReceiveData(let data):
                        //ARView Debug Options
                        if let debugOptions = try? JSONDecoder()
                            .decode(
                                _DebugOptions.self,
                                from: data
                            )
                        {
                            //FIXME: display debug options
                            // await MainActor.run {
                            //   arView?.debugOptions = ARView.DebugOptions(
                            //     rawValue: debugOptions.rawValue
                            //   )
                            // }
                        }
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
            await MainActor.run {
                isStreaming = true
            }

            for await frameData in await streamingClient.startScreenCapture() {
                multipeerClient.send(frameData)
            }
        }

        func stopStreaming() async {
            await MainActor.run {
                isStreaming = false
            }

            streamingClient.stopScreenCapture()
        }
    }

    public struct RealityCheckConnectView: View {
        @ObservedObject private var viewModel: _ViewModel

        public init() {
            self.viewModel = .init()
        }

        public init(_ viewModel: _ViewModel) {
            self.viewModel = viewModel
        }

        var connectionStateFill: Color {
            switch viewModel.connectionState {
            case .notConnected:
                return .red
            case .connecting:
                return .orange
            case .connected:
                return .green
            }
        }

        var connectionStateMessage: String {
            switch viewModel.connectionState {
            case .notConnected:
                return "not connected"
            case .connecting:
                return "connecting"
            case .connected:
                return viewModel.isStreaming
                    ? "                "
                    : "connected to: \(viewModel.hostName)"
            }
        }

        var isConnected: Bool {
            switch viewModel.connectionState {
            case .notConnected, .connecting:
                return false
            case .connected:
                return true
            }
        }

        public var body: some View {
            RealityView(
                make: { content in
                    let reference = ModelEntity(mesh: .generateSphere(radius: 0.001))
                    reference.name = "RealityCheckConnectViewReference"
                    content.add(reference)

                    viewModel.content = content
                },
                update: { content in
                    //TODO: update
                    // viewModel.content = content
                    // await viewModel.sendHierarchy()
                }
            )
            //            .task {
            //                await viewModel.startMultipeerSession()
            //            }
        }
    }

#endif
