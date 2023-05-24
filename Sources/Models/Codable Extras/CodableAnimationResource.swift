import Foundation
import RealityKit

public struct CodableAnimationResource: Codable {
  public let name: String

  init?(
    _ resource: RealityKit.AnimationResource
  ) {
    guard
      let name = resource.name,
      !name.isEmpty
    else { return nil }
    self.name = name
    //TODO: self.definition = resource.definition
  }
}
