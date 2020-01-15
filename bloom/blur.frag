#version 300 es
precision mediump float;
uniform sampler2D texMap;
in vec2 texcoord;

uniform vec2 hvSelector;

out vec4 fragColor;

#define NUM_WEIGHT 5

void main(void)
{
    // gaussion kernel http://dev.theomader.com/gaussian-kernel-calculator/
    const float weight[NUM_WEIGHT] = float[](0.227027, 0.1945946, 0.1216216, 0.054054, 0.016216);
    vec2 tex_offset = 1.0 / vec2(textureSize(texMap, 0));
    vec3 result = texture(texMap, texcoord).rgb * weight[0];
    for (int i = 1; i < NUM_WEIGHT; i++) {
        result += texture(texMap, texcoord + tex_offset * hvSelector * float(i)).rgb * weight[i];
        result += texture(texMap, texcoord - tex_offset * hvSelector * float(i)).rgb * weight[i];
    }
    fragColor = vec4(result, 1.0);
}
