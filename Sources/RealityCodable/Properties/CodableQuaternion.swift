import simd

// Wrapper struct for simd_quatf to make it Codable
public struct CodableQuaternion: Codable, Equatable {
  let vector: SIMD4<Float>

  public init(
    _ quaternion: simd_quatf
  ) {
    vector = quaternion.vector
  }

  var quaternion: simd_quatf {
    return simd_quatf(vector: vector)
  }

  public init(
    from decoder: Decoder
  ) throws {
    var container = try decoder.unkeyedContainer()
    let x = try container.decode(Float.self)
    let y = try container.decode(Float.self)
    let z = try container.decode(Float.self)
    let w = try container.decode(Float.self)
    vector = SIMD4<Float>(x, y, z, w)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.unkeyedContainer()
    try container.encode(vector.x)
    try container.encode(vector.y)
    try container.encode(vector.z)
    try container.encode(vector.w)
  }
}

extension CodableQuaternion: CustomDebugStringConvertible {
  public var debugDescription: String {
    self.quaternion.debugDescription
  }
}

//FIXME:
//extension CodableQuaternion: CustomDumpStringConvertible {
//  public var customDumpDescription: String {
//    "\(self.vector)"
//  }
//}
