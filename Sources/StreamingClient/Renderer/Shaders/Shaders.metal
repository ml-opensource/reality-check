/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A group of shaders that the renderer uses.
*/

#include <metal_stdlib>
#include <simd/simd.h>

// Include the header that this Metal shader code and the C code executing Metal API commands share.
#import "ShaderTypes.h"

using namespace metal;

typedef struct {
    float2 position [[attribute(kVertexAttributePosition)]];
    float2 texCoord [[attribute(kVertexAttributeTexcoord)]];
} ImageVertex;


typedef struct {
    float4 position [[position]];
    float2 texCoord;
} ImageColorInOut;


// Image vertex function.
vertex ImageColorInOut imageVertexTransform(ImageVertex in [[stage_in]]) {
    ImageColorInOut out;
    
    // Pass through the image vertex's position.
    out.position = float4(in.position, 0.0, 1.0);
    
    // Pass through the texture coordinate.
    out.texCoord = in.texCoord;
    
    return out;
}

// Image fragment function.
fragment float4 imageFragmentShader(ImageColorInOut in [[stage_in]],
                                    texture2d<float, access::sample> imageTextureY [[ texture(kTextureIndexY) ]],
                                    texture2d<float, access::sample> imageTextureCbCr [[ texture(kTextureIndexCbCr) ]]) {
    
    constexpr sampler colorSampler(mip_filter::linear,
                                   mag_filter::linear,
                                   min_filter::linear);
    
    const float4x4 ycbcrToRGBTransform = float4x4(
        float4(+1.0000f, +1.0000f, +1.0000f, +0.0000f),
        float4(+0.0000f, -0.3441f, +1.7720f, +0.0000f),
        float4(+1.4020f, -0.7141f, +0.0000f, +0.0000f),
        float4(-0.7010f, +0.5291f, -0.8860f, +1.0000f)
    );
    
    // Sample Y and CbCr textures to get the YCbCr color at the given texture coordinate.
    float4 ycbcr = float4(imageTextureY.sample(colorSampler, in.texCoord).r,
                          imageTextureCbCr.sample(colorSampler, in.texCoord).rg, 1.0);
    
    // Return converted RGB color.
    return ycbcrToRGBTransform * ycbcr;
}
