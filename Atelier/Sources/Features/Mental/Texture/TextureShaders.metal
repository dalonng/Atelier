#include <metal_stdlib>
using namespace metal;

struct TextureVertex {
  float4 position [[position]];
  float2 uv;
};

vertex TextureVertex textureVertex(
  uint id [[vertex_id]],
  constant float2 &scale [[buffer(0)]]
) {
  const float2 positions[] = {
    float2(-0.8, 0.8), float2(-0.8, -0.8), float2(0.8, -0.8),
    float2(-0.8, 0.8), float2(0.8, -0.8), float2(0.8, 0.8)
  };
  const float2 coordinates[] = {
    float2(0, 0), float2(0, 1), float2(1, 1),
    float2(0, 0), float2(1, 1), float2(1, 0)
  };
  TextureVertex output;
  output.position = float4(positions[id] * scale, 0, 1);
  output.uv = coordinates[id];
  return output;
}

fragment float4 textureFragment(
  TextureVertex input [[stage_in]],
  texture2d<float> image [[texture(0)]]
) {
  constexpr sampler imageSampler(coord::normalized, address::clamp_to_edge, filter::linear);
  return image.sample(imageSampler, input.uv);
}
