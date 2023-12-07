import AppFeature
import ComposableArchitecture
import SwiftUI

struct DoubleLayoutView: View {
  @State var store: StoreOf<AppCore>

  var body: some View {
    NavigatorView(store: store)
      .modifier(Inspector(store: store))
  }
}
