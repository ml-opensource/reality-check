import Foundation
import RealityKit

public struct AnchoringComponentProperties: ComponentPropertiesRepresentable {
  /// The kind of real world object to which the anchor entity should anchor.
  public let target: CodableTarget
}

public enum CodableTarget: Codable {

  case camera
  case world(transform: CodableFloat4x4)
  case anchor(identifier: UUID)
  case plane([UInt8], classifications: [UInt64], minimumBounds: SIMD2<Float>)
  case image(group: String, name: String)
  case object(group: String, name: String)
  case face
  case body

  public init(
    _ target: AnchoringComponent.Target
  ) {
    switch target {
      case .camera:
        self = .camera
      case .world(let transform):
        self = .world(transform: CodableFloat4x4(transform))
      #if os(iOS)
        case .anchor(let identifier):
          self = .anchor(identifier: identifier)
        case .plane(let alignment, let classification, let minimumBounds):
          self = .plane(
            [alignment.rawValue],
            classifications: [classification.rawValue],
            minimumBounds: minimumBounds
          )
        case .image(let group, let name):
          self = .image(group: group, name: name)
        case .object(let group, let name):
          self = .object(group: group, name: name)
        case .face:
          self = .face
        case .body:
          self = .body
      #endif
      @unknown default:
        fatalError()
    }
  }
}

//FIXME:
//extension AnchoringComponentProperties: CustomDumpReflectable {
//  public var customDumpMirror: Mirror {
//    .init(
//      self,
//      children: [
//        "target": self.target
//      ],
//      displayStyle: .struct
//    )
//  }
//}
