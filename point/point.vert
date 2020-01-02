#version 300 es
in vec3 positionIn;
uniform float scale;
uniform vec3 offset[100];

out vec3 pos;
flat out int ins;

void main(void)
{
    gl_Position = vec4(positionIn * scale + offset[gl_InstanceID], 1.0);
    pos = positionIn;
    ins = gl_InstanceID;
}
