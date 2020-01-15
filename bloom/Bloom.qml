import Qt3D.Core 2.12
import Qt3D.Render 2.12
import Qt3D.Extras 2.12

Entity {
    id: root

    property real gamma: 2.2
    property real exposure: 1.0

    Buffer {
        id: vertexBuffer
        type: Buffer.VertexBuffer
        data: new Float32Array([
             1, -1, 0, 1, 0,
             1,  1, 0, 1, 1,
            -1, -1, 0, 0, 0,
            -1,  1, 0, 0, 1,
        ])
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
                    byteStride: 5 * 4
                    buffer: vertexBuffer
                    count: 4
                },
                Attribute {
                    name: "texIn"
                    attributeType: Attribute.VertexAttribute
                    vertexBaseType: Attribute.Float
                    vertexSize: 2
                    byteOffset: 3 * 4
                    byteStride: 5 * 4
                    buffer: vertexBuffer
                    count: 4
                }
            ]
        }
    }

    Material {
        id: material

        effect: Effect {
            techniques: [
                Technique {
                    graphicsApiFilter {
                        api: GraphicsApiFilter.OpenGLES
                        profile: GraphicsApiFilter.CoreProfile
                        majorVersion: 3
                        minorVersion: 0
                    }
                    renderPasses: [
                        RenderPass {
                            filterKeys: [FilterKey { name: "pass"; value: "blur" }]

                            shaderProgram: ShaderProgram {
                                vertexShaderCode: loadSource("qrc:/blur.vert")
                                fragmentShaderCode: loadSource("qrc:/blur.frag")
                            }
                        },
                        RenderPass {
                            filterKeys: [FilterKey { name: "pass"; value: "combine" }]

                            parameters: [
                                Parameter { name: "gamma"; value: root.gamma },
                                Parameter { name: "exposure"; value: root.exposure }
                            ]

                            shaderProgram: ShaderProgram {
                                vertexShaderCode: loadSource("qrc:/combine.vert")
                                fragmentShaderCode: loadSource("qrc:/combine.frag")
                            }
                        }
                    ]
                }
            ]
        }
    }

    components: [mesh, material]
}
