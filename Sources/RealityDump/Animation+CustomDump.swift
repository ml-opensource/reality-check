import RealityKit

extension RealityKit.AnimationResource: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(
      self,
      children: [
        "name": self.name,
        "definition": self.definition,
      ]
    )
  }
}

//TODO: describe the conforming types of AnimationDefinition
//https://developer.apple.com/documentation/realitykit/animationdefinition
//AnimationGroup
//AnimationView
//BlendTreeAnimation
//FromToByAnimation
//OrbitAnimation
//SampledAnimation
//extension RealityKit.AnimationDefinition: CustomDumpReflectable {
//  public var customDumpMirror: Mirror {
//    .init(
//      self,
//      children: [
//        "name": self.name,
//        "bindTarget": self.bindTarget,
//        "blendLayer": self.blendLayer,
//        "speed": self.speed,
//        "delay": self.delay,
//        "duration": self.duration,
//        "offset": self.offset,
//        "trimDuration": self.trimDuration,
//        "trimStart": self.trimStart,
//        "trimEnd": self.trimEnd,
//      ]
//    )
//  }
//}
