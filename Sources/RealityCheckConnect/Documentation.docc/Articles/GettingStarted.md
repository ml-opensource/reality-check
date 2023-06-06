# Getting Started

Import the library, add the connect component to your view hierarchy, configure it, declare the neccessary permissions, and establish the connection (with optional streaming) to the RealityCheck macOS app.

## Overview

Using RealityCheck to inspect a RealityKit's ARView hierarchy involves having a reference to an ARView instance running on your iOS device. To control streaming, transmission of updated hierarchies, and visualize the connection state, a visual component overlay called ``RealityCheckConnectView`` is provided.

The ``RealityCheckConnectView`` handles the internal publishing and transmission of data using MultipeerConnectivity. To use this feature, you'll need to modify your target properties to explicitly include the necessary Bonjour permissions on the `Info.plist`.

To get started, add the RealityCheck library using Swift Package Manager (SPM) and import it into the relevant document where you want to use it. For SwiftUI-based projects, Xcode's library provides a convenient component for integration.

Make sure to download the latest version of the RealityCheck macOS app from the provided source.

![A MacBook and an iPhone running RealityCheck together](getting_started_cover)

### Integration

Start by including the RealityCheck library in your project. You can do this by downloading it from the official repository or adding it as a dependency using Swift Package Manager directly on Xcode.

You can add RealityCheck to a RealityKit project on Xcode by adding it as a package dependency.

1. From the File menu, select Add Packages...
2. Enter [https://github.com/monstar-lab-oss/reality-check](https://github.com/monstar-lab-oss/reality-check#getting-started) into the package repository URL text field
3. Click the Add Package button to confirm

![The Swift Package Manager import interface in Xcode](getting_started_spm-1)

4. Select RealityCheckConnect from the Choose Package Products screen and verify that it's being added to the desired Target

![The Swift Package Manager import interface in Xcode step 2, displaying the product chooser](getting_started_spm-2)
![The Target Frameworks, Libraries and Embedded Content Xcode interface displaying the included RealityCheckConnect library](getting_started_spm-3)

### Include necessary Bonjour services

Enable network communication between your iOS app and the RealityCheck macOS app by adding the required `NSBonjourServices` key to your app's Info.plist file.

```xml
<key>NSBonjourServices</key>
<array>
    <string>_reality-check._tcp</string>
    <string>_reality-check._udp</string>
</array>
```

> Important: As they're used to being discovered by the host, keep the values for the bonjour services unmodified.

![Xcode Info.plist editor with the required NSBonjourServices defined](getting_started_bonjour)

> Tip: Additionally, when utilizing the local network, users are prompted by the system to grant explicit permission to the app. To customize the messaging of this prompt, your app can include the `NSLocalNetworkUsageDescription` key.

### Add the connect component to your view hierarchy

Incorporate the necessary SwiftUI components provided by the `RealityCheckConnect` library into your project's view hierarchy. The ``RealityCheckConnectView`` component handles the connection between your app and the RealityCheck macOS app and allows to control the streaming and ARView hierarchy transmission.

```swift
import RealityCheckConnect

struct ContentView: View {  
  var body: some View {
    ZStack {
      ARViewContainer().edgesIgnoringSafeArea(.all)
      RealityCheckConnectView()
    }
  }
}
```

<!--![The Library interface in Xcode displaying the RealityConnectView SwiftUI component](getting_started_component_preview)-->

> Tip: A ready-to-use component is available in the Xcode library

![The Library interface in Xcode displaying the RealityConnectView SwiftUI component](getting_started_library)

### Configure the component (optional)

By default, the ``RealityCheckConnectView`` will handle connection and streaming, but things get even better if you pass a reference of your ARView. Using the `RealityCheckConnectView(_: ARView)` constructor, will allow RealityCheck macOS app to inspect and display your AR hierarchy, and offer several debugging options.

```swift
import RealityCheckConnect

struct ContentView: View {
  let arViewContainer = ARViewContainer()
  
  var body: some View {
    ZStack {
      arViewContainer.edgesIgnoringSafeArea(.all)
      RealityCheckConnectView(arViewContainer.arView)
    }
  }
}
```

### Connect to RealityCheck macOS app

Once you've reached this stage, run your application, and you'll find it displayed in the "inspectable apps" window of the RealityCheck macOS app. After establishing a connection, you can start or stop streaming at your convenience and send updated versions of your ARView whenever needed. RealityCheck will take care of displaying and inspecting the ARView for you. 🖖

![The RealityCheck macOS app displaying the chooser window with an iOS app that is set up properly.](getting_started_macos_inspectable_apps_window)
