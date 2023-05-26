import SwiftUI

public struct RealityCheckConnectLibraryViewContent: LibraryContentProvider {

  @LibraryContentBuilder
  public var views: [LibraryItem] {
    LibraryItem(
      RealityCheckConnectView(),
      title: "RealityCheck Connect View",
      category: .control
    )
  }
}
