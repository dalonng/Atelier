#pragma once
#include <metal_stdlib>
using namespace metal;

struct Uniforms {
  float4x4 mvpMatrix;
  float4 tintColor;
};

struct ShapeVertex {
  float4 position [[position]];
  float3 color;
};
