#version 300 es
precision mediump float;
in vec3 color;

uniform float threshold;
layout(location = 0) out vec4 fragColor0;
layout(location = 1) out vec4 fragColor1;

void main(void)
{
    fragColor0 = vec4(color, 1.0);
    float brightness = dot(fragColor0.rgb, vec3(0.2126, 0.7152, 0.0722));
    if (brightness > threshold)
        fragColor1 = vec4(fragColor0.rgb, 1.0);
    else
        fragColor1 = vec4(0.0, 0.0, 0.0, 1.0);
}
