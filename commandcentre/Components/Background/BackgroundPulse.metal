//
//  BackgroundPulse.metal
//  commandcentre
//
//  Created by Filip Šašala on 07/02/2026.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

[[ stitchable ]] half4 backgroundPulse(float2 position, half4 color, float time) {
    float pulse = 0.02f * sin(time);
    half3 rgb = color.rgb * half(1.0f + pulse);

    return half4(rgb, color.a);
}

