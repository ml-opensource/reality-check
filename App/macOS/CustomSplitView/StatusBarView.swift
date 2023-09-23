import SwiftUI

struct StatusBarView: View {
  @Environment(\.controlActiveState) private var controlActive

  static let height = 27.0

  @Environment(\.colorScheme) private var colorScheme

  let proxy: SplitViewProxy

  @Binding var collapsed: Bool

  /// The actual status bar
  var body: some View {
    HStack(alignment: .center, spacing: 10) {
      Spacer()
      // StatusBarDivider()
      StatusBarToggleDrawerButton(collapsed: $collapsed)
    }
    .padding(.horizontal, 10)
    .cursor(.resizeUpDown)
    .frame(height: Self.height)
    .background(.bar)
    .padding(.top, 1)
    .overlay(alignment: .top) {
      Divider()
        .overlay(Color(nsColor: colorScheme == .dark ? .black : .clear))
    }
    .gesture(dragGesture)
    .disabled(controlActive == .inactive)
  }

  /// A drag gesture to resize the drawer beneath the status bar
  private var dragGesture: some Gesture {
    DragGesture(coordinateSpace: .global)
      .onChanged { value in
        proxy.setPosition(of: 0, position: value.location.y + Self.height / 2)
      }
  }
}

struct StatusBarDivider: View {
  var body: some View {
    Divider()
      .frame(maxHeight: 12)
  }
}

extension View {
  func cursor(_ cursor: NSCursor) -> some View {
    onHover {
      if $0 {
        cursor.push()
      } else {
        cursor.pop()
      }
    }
  }
}

//MARK: -

struct StatusBarToggleDrawerButton: View {

  @Binding
  var collapsed: Bool

  init(collapsed: Binding<Bool>) {
    self._collapsed = collapsed
  }

  func togglePanel() {
    withAnimation {
      collapsed.toggle()
    }
  }

  internal var body: some View {
    Button {
      togglePanel()
    } label: {
      Image(systemName: "square.bottomthird.inset.filled")
    }
    .buttonStyle(.plain)
    .keyboardShortcut("Y", modifiers: [.command, .shift])
    .onHover { isHovering($0) }
  }
}
