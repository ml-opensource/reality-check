import Accelerate
import RealityKit

/// Creates a 3D rotation transform that rotates around the Z axis by the angle that you provide
/// - Parameter radians: The amount (in radians) to rotate around the Z axis.
/// - Returns: A Z-axis rotation transform.
public func rotationAroundZAxisTransform(radians: Float) -> simd_float4x4 {
    simd_float4x4(
        SIMD4<Float>(cos(radians), sin(radians), 0, 0),
        SIMD4<Float>(-sin(radians), cos(radians), 0, 0),
        SIMD4<Float>(0, 0, 1, 0),
        SIMD4<Float>(0, 0, 0, 1)
    )
}

/// Creates a 3D rotation transform that rotates around the X axis by the angle that you provide
/// - Parameter radians: The amount (in radians) to rotate around the X axis.
/// - Returns: A X-axis rotation transform.
public func rotationAroundXAxisTransform(radians: Float) -> simd_float4x4 {
    simd_float4x4(
        SIMD4<Float>(1, 0, 0, 0),
        SIMD4<Float>(0, cos(radians), sin(radians), 0),
        SIMD4<Float>(0, -sin(radians), cos(radians), 0),
        SIMD4<Float>(0, 0, 0, 1)
    )
}

/// Creates a 3D rotation transform that rotates around the Y axis by the angle that you provide
/// - Parameter radians: The amount (in radians) to rotate around the Y axis.
/// - Returns: A Y-axis rotation transform.
public func rotationAroundYAxisTransform(radians: Float) -> simd_float4x4 {
    simd_float4x4(
        SIMD4<Float>(cos(radians), 0, -sin(radians), 0),
        SIMD4<Float>(0, 1, 0, 0),
        SIMD4<Float>(sin(radians), 0, cos(radians), 0),
        SIMD4<Float>(0, 0, 0, 1)
    )
}
/// Returns the rotational transform component from a homogeneous matrix.
/// - Parameter matrix: The homogeneous transform matrix.
/// - Returns: The 3x3 rotation matrix.
public func rotationTransform(_ matrix: matrix_float4x4) -> matrix_float3x3 {
    // extract the rotational component from the transform matrix
    let (col1, col2, col3, _) = matrix.columns
    let rotationTransform = matrix_float3x3(
        simd_float3(x: col1.x, y: col1.y, z: col1.z),
        simd_float3(x: col2.x, y: col2.y, z: col2.z),
        simd_float3(x: col3.x, y: col3.y, z: col3.z)
    )
    return rotationTransform
}
