#version 300 es
in vec3 positionIn;
in vec2 texIn;

out vec2 texcoord;

void main(void)
{
    gl_Position = vec4(positionIn, 1.0);
    texcoord = texIn;
}
