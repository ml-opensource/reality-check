import simd

public struct CodableFloat4x4: Codable {
  let columns: (SIMD4<Float>, SIMD4<Float>, SIMD4<Float>, SIMD4<Float>)

  init(
    _ float4x4: simd_float4x4
  ) {
    columns = (
      float4x4.columns.0, float4x4.columns.1, float4x4.columns.2,
      float4x4.columns.3
    )
  }

  var float4x4: simd_float4x4 {
    return simd_float4x4(columns: (columns.0, columns.1, columns.2, columns.3))
  }

  public init(
    from decoder: Decoder
  ) throws {
    var container = try decoder.unkeyedContainer()
    let column1 = try container.decode(SIMD4<Float>.self)
    let column2 = try container.decode(SIMD4<Float>.self)
    let column3 = try container.decode(SIMD4<Float>.self)
    let column4 = try container.decode(SIMD4<Float>.self)
    columns = (column1, column2, column3, column4)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.unkeyedContainer()
    try container.encode(columns.0)
    try container.encode(columns.1)
    try container.encode(columns.2)
    try container.encode(columns.3)
  }
}

extension CodableFloat4x4: CustomDebugStringConvertible {
  public var debugDescription: String {
    self.float4x4.debugDescription
  }
}

//FIXME: 
//extension CodableFloat4x4: CustomDumpStringConvertible {
//  public var customDumpDescription: String {
//    "\(self.float4x4)"
//  }
//}
