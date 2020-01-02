#version 300 es
precision mediump float;
in vec3 pos;
flat in int ins;

uniform vec4 color[100];

out vec4 fragColor;

void main(void)
{
    fragColor = color[ins] * max(1.0 - dot(pos, pos), 0.0);
}
