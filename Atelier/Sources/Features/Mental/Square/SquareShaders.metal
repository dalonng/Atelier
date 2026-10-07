#include "../Shared/ShapeShaderTypes.h"

vertex ShapeVertex squareVertex(
  uint id [[vertex_id]],
  constant float2 &scale [[buffer(0)]],
  constant Uniforms &uniforms [[buffer(2)]]
) {
  const float2 positions[] = {
    float2(-0.6, 0.6), float2(-0.6, -0.6), float2(0.6, -0.6),
    float2(-0.6, 0.6), float2(0.6, -0.6), float2(0.6, 0.6)
  };
  const float2 point = positions[id];
  ShapeVertex output;
  output.position = float4(point * scale, 0, 1);
  output.color = float3(point.x * 0.5 + 0.5, point.y * 0.5 + 0.5, 0.9);
  return output;
}
