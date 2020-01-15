#version 300 es
precision mediump float;
uniform sampler2D blurTexMap;
uniform sampler2D modelTexMap;
in vec2 texcoord;
uniform float gamma;
uniform float exposure;

out vec4 fragColor;

void main(void)
{
    vec3 hdrColor = texture(modelTexMap, texcoord).rgb;
    vec3 bloomColor = texture(blurTexMap, texcoord).rgb;
    hdrColor += bloomColor; // additive blending
    // tone mapping
    vec3 result = vec3(1.0) - exp(-hdrColor * exposure);
    // also gamma correct while we're at it
    result = pow(result, vec3(1.0 / gamma));
    fragColor = vec4(result, 1.0);
}
