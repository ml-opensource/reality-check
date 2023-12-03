import ComposableArchitecture
import MultipeerClient
import SwiftUI

public struct MainToolbar: CustomizableToolbarContent {
  @Bindable var store: StoreOf<AppCore>

  public init(store: StoreOf<AppCore>) {
    self.store = store
  }

  public var body: some CustomizableToolbarContent {
    ToolbarItem(id: "SessionState", placement: .status) {
      SessionStateView(store.multipeerConnection.sessionState)
        .labelStyle(.titleAndIcon)
    }

    ToolbarItem(id: "Spacer") {
      Spacer()
    }

    ToolbarItem(id: "ConnectionSetup") {
      Toggle(
        isOn: $store.isConnectionSetupPresented,
        label: { Label("Connection Setup", systemImage: "bonjour") }
      )
      .symbolRenderingMode(.multicolor)
      .help("Connection Setup")
      .keyboardShortcut("S", modifiers: [.command, .option])
      .popover(
        isPresented: $store.isConnectionSetupPresented,
        content: {
          ConnectionSetupView(
            store: store.scope(
              state: \.multipeerConnection,
              action: AppCore.Action.multipeerConnection
            )
          )
        }
      )
    }

    ToolbarItem(id: "Layout") {
      Picker("Layout", selection: $store.layout) {
        Button("Double", systemImage: "rectangle.split.2x1") {
          store.layout = .double
        }
        .tag(Layout.double)
        .help("Two Columns")

        Button("Triple", systemImage: "rectangle.split.3x1") {
          store.layout = .triple
        }
        .tag(Layout.triple)
        .help("Three Columns")
      }
      .pickerStyle(.segmented)
      .help("Panel Layout")
    }

    ToolbarItem(id: "Console") {
      Toggle(
        isOn: $store.isConsolePresented,
        label: { Label("Console", systemImage: "doc.plaintext") }
      )
      .help(store.isConsolePresented ? "Hide Console" : "Show Console")
      .keyboardShortcut("C", modifiers: [.command, .option])
    }
  }
}

struct SessionStateView: View {
  @Environment(\.openWindow) private var openWindow
  private let sessionState: MultipeerClient.SessionState

  init(
    _ sessionState: MultipeerClient.SessionState
  ) {
    self.sessionState = sessionState
  }

  var contextualColor: Color {
    switch sessionState {
      case .notConnected:
        return .red
      case .connecting:
        return .orange
      case .connected:
        return .green
    }
  }

  var contextualLabel: String {
    switch sessionState {
      case .notConnected:
        return "Disconnected"
      case .connecting:
        return "Connecting"
      case .connected:
        return "Connected"
    }
  }

  var contextualImage: String {
    switch sessionState {
      case .notConnected:
        return "nosign"
      case .connecting:
        return "bolt"
      case .connected:
        return "checkmark.seal.fill"
    }
  }

  var body: some View {
    Label(contextualLabel, systemImage: contextualImage)
      .foregroundStyle(contextualColor)
  }
}
