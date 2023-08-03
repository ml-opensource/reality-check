#include <metal_stdlib>
#include <RealityKit/RealityKit.h>

using namespace metal;

[[visible]]
void wireframe_shader(realitykit::surface_parameters params)
{
    half3 baseColorTint = (half3)params.material_constants().base_color_tint();
    params.surface().set_base_color(baseColorTint);
    
    ////////////////////////////////////////////////////////////////
    // Render only a wireframe
    ////////////////////////////////////////////////////////////////
    float lineThickness = 0.03;
    
    // Retrieve the entity's texture coordinates.
    float2 uv = params.geometry().uv0();
    float2 scale = 1;
    
    // Compute threshold for discarding rendering
    float2 thresh = float2(lineThickness) / scale;
    if (uv.x > thresh[0] && uv.x < (1.0 - thresh[0]) && uv.y > thresh[1] && uv.y < (1.0 - thresh[1])) {
        params.surface().set_emissive_color(half3(1, 1, 1));
        params.surface().set_opacity(0.3);
    }
    
    float2 thresh2 = float2(lineThickness) / 0.7;
    if (uv.x > thresh2[0] && uv.x < (1.0 - thresh2[0]) && uv.y > thresh2[1] && uv.y < (1.0 - thresh2[1])) {
        discard_fragment();
    }
}
