//
//  BackgroundPulse.metal
//  commandcentre
//
//  Created by Filip Šašala on 07/02/2026.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

[[ stitchable ]] half4 backgroundPulse(
    float2 position,
    half4 color,
    float time,
    float pulseAmplitude,
    float ditherAmount,
    float ditherSpeed
) {
    float pulse = pulseAmplitude * sin(time);
    float noise = fract(sin(dot(position, float2(12.9898f, 78.233f)) + time * ditherSpeed) * 43758.5453f);
    noise = (noise - 0.5f) * ditherAmount;
    half3 rgb = color.rgb * half(1.0f + pulse) + half3(half(noise));

    return half4(rgb, color.a);
}
