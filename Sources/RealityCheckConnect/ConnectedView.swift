import Dependencies
import MultipeerClient
import StreamingClient
import SwiftUI

struct ConnectedView: View {
  @State private var isRecording = false

  let hostName: String

  @Dependency(\.multipeerClient) var multipeerClient
  @Dependency(\.streamingClient) var streamingClient

  var body: some View {
    Text("connected to: \(hostName)")
      .font(.caption)
      .padding(8)
      .background(Capsule(style: .continuous).fill(.green))

    Spacer()

    Button(
      action: {
        //TODO: Toggle start/stop recording at the client level
        defer { isRecording.toggle() }
        if isRecording {
          //TODO: stop streaming
        } else {
          //MARK: 3. Stream
          Task {
            await startStreaming()
          }
        }
      },
      label: {
        ZStack {
          Circle().stroke(lineWidth: 4).fill(.white)

          RoundedRectangle(cornerRadius: isRecording ? 8 : 40, style: .continuous)
            .fill(.purple)
            .padding(isRecording ? 24 : 6)
            .animation(.easeInOut(duration: 0.15), value: isRecording)
        }
        .shadow(radius: 3)
      }
    )
    .frame(width: 88, height: 88)
    .buttonStyle(.plain)
  }

  private func startStreaming() async {
    for await frameData in await streamingClient.startScreenCapture() {
      multipeerClient.send(frameData)
    }
  }
}
