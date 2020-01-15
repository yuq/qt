import Qt3D.Core 2.12
import Qt3D.Render 2.12
import Qt3D.Extras 2.12

Entity {
    id: root

    property real threshold: 1.0

    Buffer {
        id: vertexBuffer
        type: Buffer.VertexBuffer
        data: new Float32Array([
             0.5, -0.5, 0, 0, 0, 0,
             0.5,  0.5, 0, 1, 1, 1,
            -0.5, -0.5, 0, 1, 1, 1,
            -0.5,  0.5, 0, 2, 2, 2,
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
                    byteStride: 6 * 4
                    buffer: vertexBuffer
                    count: 4
                },
                Attribute {
                    name: "colorIn"
                    attributeType: Attribute.VertexAttribute
                    vertexBaseType: Attribute.Float
                    vertexSize: 3
                    byteOffset: 3 * 4
                    byteStride: 6 * 4
                    buffer: vertexBuffer
                }
            ]
        }
    }

    Material {
        id: material

        parameters: [
            Parameter { name: "threshold"; value: root.threshold }
        ]

        effect: Effect {
            techniques: [
                Technique {
                    graphicsApiFilter {
                        api: GraphicsApiFilter.OpenGLES
                        profile: GraphicsApiFilter.CoreProfile
                        majorVersion: 3
                        minorVersion: 0
                    }
                    renderPasses: RenderPass {
                        filterKeys: [FilterKey { name: "pass"; value: "model" }]
                        shaderProgram: ShaderProgram {
                            vertexShaderCode: loadSource("qrc:/model.vert")
                            fragmentShaderCode: loadSource("qrc:/model.frag")
                        }
                    }
                }
            ]
        }
    }

    components: [mesh, material]
}
