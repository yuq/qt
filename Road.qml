import QtQuick 2.12
import Qt3D.Core 2.12
import Qt3D.Render 2.12

Entity {
    id: road

    Buffer {
        id: vertexBuffer
        property int index: 0
        property int num: 100
        property double range: 0.1

        type: Buffer.VertexBuffer
        accessType: Buffer.Write
        usage: Buffer.DynamicDraw

        onIndexChanged: {
            var v = new Float32Array(2 * num * 3);
            var i;
            for (i = 0; i < num; i++) {
                v[i * 6 + 0] = i * 2.0 / num - 1;
                v[i * 6 + 1] = range * Math.sin((i + index) * 2 * Math.PI / num) + 0.5;
                v[i * 6 + 2] = 0;

                v[i * 6 + 3] = i * 2.0 / num - 1;
                v[i * 6 + 4] = range * Math.sin((i + index) * 2 * Math.PI / num) - 0.5;
                v[i * 6 + 5] = 0;
            }
            data = v;
        }

        NumberAnimation on index { from: 0; to: 6000; duration: 100000}
    }

    GeometryRenderer {
        id: mesh
        instanceCount: 1
        indexOffset: 0
        firstInstance: 0
        primitiveType: GeometryRenderer.TriangleStrip
        geometry: Geometry {
            attributes: [
                Attribute {
                    name: "positionIn"
                    attributeType: Attribute.VertexAttribute
                    vertexBaseType: Attribute.Float
                    vertexSize: 3
                    byteOffset: 0
                    byteStride: 3 * 4
                    buffer: vertexBuffer
                    count: vertexBuffer.num * 2
                }
            ]
        }
    }

    Material {
        id: material

        parameters: [
            Parameter {
                name: "color"
                value: Qt.vector4d(0.35, 0.35, 0.4, 1.0)
            }
        ]

        FilterKey {
            id: forward
            name: "renderingStyle"
            value: "forward"
        }

        ShaderProgram {
            id: shader
            vertexShaderCode: loadSource("qrc:/color.vert")
            fragmentShaderCode: loadSource("qrc:/color.frag")
        }

        effect: Effect {
            techniques: [
                Technique {
                    filterKeys: [forward]
                    graphicsApiFilter {
                        api: GraphicsApiFilter.OpenGL
                        profile: GraphicsApiFilter.CoreProfile
                        majorVersion: 2
                        minorVersion: 0
                    }
                    renderPasses: RenderPass {
                        shaderProgram: shader
                    }
                }
            ]
        }
    }

    components: [mesh, material]
}
