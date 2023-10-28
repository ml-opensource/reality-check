import CustomDump
import simd

extension SIMD3: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(
      self,
      children: [
        "x": self.x,
        "y": self.y,
        "z": self.z,
      ]
    )
  }
}

extension SIMD4: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(
      self,
      children: [
        "x": self.x,
        "y": self.y,
        "z": self.z,
        "w": self.w
      ]
    )
  }
}
