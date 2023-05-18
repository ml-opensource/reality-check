/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Header that contain types and enumeration constants that the Metal shaders and the C/ObjC source share.
*/

//
//
#ifndef ShaderTypes_h
#define ShaderTypes_h

#include <simd/simd.h>


// Buffer index values that the shader and the C code share to ensure the Metal shader buffer inputs match Metal API buffer set calls.
typedef enum BufferIndices {
    kBufferIndexMeshPositions    = 0
} BufferIndices;

// Attribute index values that the shader and the C code share to ensure the Metal shader vertex attribute indices match the Metal API vertex descriptor attribute indices.
typedef enum VertexAttributes {
    kVertexAttributePosition  = 0,
    kVertexAttributeTexcoord  = 1
} VertexAttributes;

// Texture index values that the shader and the C code share to ensure the Metal shader texture indices match the indices of Metal API texture set calls.
typedef enum TextureIndices {
    kTextureIndexY        = 0,
    kTextureIndexCbCr     = 1
} TextureIndices;

#endif /* ShaderTypes_h */
