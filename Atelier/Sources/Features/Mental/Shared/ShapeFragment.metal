#include "ShapeShaderTypes.h"

fragment float4 shapeFragment(ShapeVertex input [[stage_in]]) {
  return float4(input.color, 1);
}
