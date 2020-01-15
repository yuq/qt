#version 300 es
in vec3 positionIn;
in vec3 colorIn;

out vec3 color;

void main(void)
{
    gl_Position = vec4(positionIn, 1);
    color = colorIn;
}
