import RealityKit
import SwiftUI

/// The `RealityCheckConnectLibraryViewContent` struct provides convenience access to the `RealityCheckConnectView` through the Xcode library panel.
///
/// The `RealityCheckConnectLibraryViewContent` struct is used to register the `RealityCheckConnectView` as a library item, allowing developers to easily access and use it from the Xcode library panel. It provides a convenient way to add the `RealityCheckConnectView` to their SwiftUI projects via drag and drop .
///
public struct RealityCheckConnectLibraryViewContent: LibraryContentProvider {

  @LibraryContentBuilder
  public var views: [LibraryItem] {
    LibraryItem(
      RealityCheckConnectView().arView(ARView()),
      title: "RealityCheckConnect View",
      category: .control
    )
  }
}

public struct LibraryModifierContent: LibraryContentProvider {
  public func modifiers(base: RealityCheckConnectView) -> [LibraryItem] {
    LibraryItem(base.arView(ARView()))
  }
}
