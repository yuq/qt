import QtQuick 2.12
import Qt3D.Core 2.12
import Qt3D.Render 2.12
import Qt3D.Extras 2.12

Entity {
    id: point

    Buffer {
        id: vertexBuffer
        type: Buffer.VertexBuffer
        data: new Float32Array([
             1, -1, 0,
             1,  1, 0,
            -1, -1, 0,
            -1,  1, 0,
        ])
    }

    Buffer {
        id: indexBuffer
        type: Buffer.IndexBuffer
        data: new Uint8Array([
            0, 1, 2, 3
        ])
    }

    GeometryRenderer {
        id: mesh
        instanceCount: 4
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
                },
                Attribute {
                    attributeType: Attribute.IndexAttribute
                    vertexBaseType: Attribute.UnsignedByte
                    buffer: indexBuffer
                    count: 4
                }
            ]
        }
    }

    Material {
        id: material

        parameters: [
            Parameter {
                name: "color[0]"
                value: [
                    Qt.vector4d(1.0, 0.0, 0.0, 1.0),
                    Qt.vector4d(0.0, 1.0, 0.0, 1.0),
                    Qt.vector4d(0.0, 0.0, 1.0, 1.0),
                    Qt.vector4d(0.0, 1.0, 1.0, 1.0)
                ]
            },
            Parameter {
                name: "scale"
                value: 0.25
            },
            Parameter {
                name: "offset[0]"
                value: [
                    Qt.vector3d( 0.5,  0.5, 0.0),
                    Qt.vector3d( 0.5, -0.5, 0.0),
                    Qt.vector3d(-0.5, -0.5, 0.0),
                    Qt.vector3d(-0.5,  0.5, 0.0)
                ]
            }
        ]

        FilterKey {
            id: forward
            name: "renderingStyle"
            value: "forward"
        }

        ShaderProgram {
            id: gles_shader
            vertexShaderCode: loadSource("qrc:/gles/point.vert")
            fragmentShaderCode: loadSource("qrc:/gles/point.frag")
        }

        ShaderProgram {
            id: gl_shader
            vertexShaderCode: loadSource("qrc:/gl/point.vert")
            fragmentShaderCode: loadSource("qrc:/gl/point.frag")
        }

        effect: Effect {
            techniques: [
                Technique {
                    filterKeys: [forward]
                    graphicsApiFilter {
                        api: GraphicsApiFilter.OpenGLES
                        profile: GraphicsApiFilter.CoreProfile
                        majorVersion: 3
                        minorVersion: 0
                    }
                    renderPasses: RenderPass {
                        shaderProgram: gles_shader
                        renderStates: [
                            BlendEquationArguments {
                                sourceRgb: BlendEquationArguments.SourceAlpha
                                destinationRgb: BlendEquationArguments.OneMinusSourceAlpha
                                sourceAlpha: BlendEquationArguments.Zero
                                destinationAlpha: BlendEquationArguments.One
                            }
                        ]
                    }
                },
                Technique {
                    filterKeys: [forward]
                    graphicsApiFilter {
                        api: GraphicsApiFilter.OpenGL
                        profile: GraphicsApiFilter.CoreProfile
                        majorVersion: 3
                        minorVersion: 3
                    }
                    renderPasses: RenderPass {
                        shaderProgram: gl_shader
                        renderStates: [
                            BlendEquationArguments {
                                sourceRgb: BlendEquationArguments.SourceAlpha
                                destinationRgb: BlendEquationArguments.OneMinusSourceAlpha
                                sourceAlpha: BlendEquationArguments.Zero
                                destinationAlpha: BlendEquationArguments.One
                            }
                        ]
                    }
                }
            ]
        }
    }

    components: [mesh, material]
}
