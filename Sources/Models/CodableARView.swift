import Dependencies
import Foundation
import RealityKit

public struct CodableScene: Codable, Equatable {
  public let anchors: [IdentifiableEntity]

  init(
    anchors: [IdentifiableEntity]
  ) {
    self.anchors = anchors
  }

  //TODO: allow anchors identification at this level
  // init(
  //   _ scene: RealityKit.Scene
  // ) {
  //   self.anchors = ???
  // }
}

extension RealityKit.ARView.DebugOptions: Codable {}

public struct CodableARView: Codable, Equatable {
  //MARK: Working with the Scene
  public let scene: CodableScene

  //MARK: Debugging the Session
  ///The current debugging options.
  public let debugOptions: RealityKit.ARView.DebugOptions

  public init(
    _ arView: RealityKit.ARView,
    anchors: [IdentifiableEntity]
  ) {
    self.scene = CodableScene(anchors: anchors)
    self.debugOptions = arView.debugOptions
  }
}

/*
  /// #Working with the Scene
  var scene: Scene
 // The scene that the view renders and simulates.

 /// #Configuring the AR Session
  var session: ARSession
  // The AR session that supports the view’s rendering.
  var automaticallyConfigureSession: Bool
  // An indication of whether to use an automatically configured AR session.
  var renderOptions: ARView.RenderOptions
  // The render options that configure the view’s AR session.
  struct RenderOptions
  // The available rendering options that you use to selectively disable certain rendering effects.
  var renderCallbacks: ARView.RenderCallbacks
  // A container that holds the view’s render callbacks.
  struct RenderCallbacks
  // A container that holds the view’s render callbacks.

  /// #Providing Environmental Context
  var environment: ARView.Environment
  // The view’s background, lighting, and acoustic properties.
  var physicsOrigin: Entity?
  // The entity that defines the origin of the scene’s physics simulation.
  var audioListener: Entity?
  // The entity that defines the listener position and orientation for spatial audio.

  /// #Managing the Camera
  var cameraMode: ARView.CameraMode
  // A setting that chooses between the AR session’s camera and a virtual one.

  var cameraTransform: Transform
  // The transform of the currently active camera.

 /// #Managing the View
  var frame: NSRect
  // The frame rectangle, which describes the view’s location and size in the coordinate system of the view’s superview.
  var contentScaleFactor: CGFloat
  // The scale factor of the content in the view.

  /// #Debugging the Session
  var debugOptions: ARView.DebugOptions
  The current debugging options.
   */
