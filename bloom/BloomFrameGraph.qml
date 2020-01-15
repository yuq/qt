import Qt3D.Core 2.12
import Qt3D.Render 2.12
import Qt3D.Extras 2.12

RenderSettings {
    id: root

    property int width: 512
    property int height: 512

    activeFrameGraph: RenderSurfaceSelector {
        RenderPassFilter {
            matchAny: FilterKey { name: "pass"; value: "model" }

            RenderTargetSelector {
                target: RenderTarget {
                    attachments: [
                        RenderTargetOutput {
                            attachmentPoint: RenderTargetOutput.Color0
                            texture: Texture2D {
                                id: modelPassColorTexture
                                width: root.width
                                height: root.height
                                format: Texture.RGBFormat
                                generateMipMaps: false
                                magnificationFilter: Texture.Linear
                                minificationFilter: Texture.Linear
                                wrapMode {
                                    x: WrapMode.ClampToEdge
                                    y: WrapMode.ClampToEdge
                                }
                            }
                        },
                        RenderTargetOutput {
                            attachmentPoint: RenderTargetOutput.Color1
                            texture: Texture2D {
                                id: modelPassBrightTexture
                                width: root.width
                                height: root.height
                                format: Texture.RGBFormat
                                generateMipMaps: false
                                magnificationFilter: Texture.Linear
                                minificationFilter: Texture.Linear
                                wrapMode {
                                    x: WrapMode.ClampToEdge
                                    y: WrapMode.ClampToEdge
                                }
                            }
                        },
                        RenderTargetOutput {
                            attachmentPoint: RenderTargetOutput.Depth
                            texture: Texture2D {
                                width: root.width
                                height: root.height
                                format: Texture.DepthFormat
                                generateMipMaps: false
                            }
                        }
                    ]
                }

                ClearBuffers {
                    buffers: ClearBuffers.ColorDepthBuffer
                    //clearColor: "#262626"
                }
            }
        }

        RenderPassFilter {
            matchAny: [ FilterKey { name: "pass"; value: "blur" } ]

            parameters: [
                Parameter { name: "texMap"; value: modelPassBrightTexture },
                Parameter { name: "hvSelector"; value: Qt.vector2d(1, 0) }
            ]

            RenderTargetSelector {
                target: RenderTarget {
                    attachments: [
                        RenderTargetOutput {
                            attachmentPoint: RenderTargetOutput.Color0
                            texture: Texture2D {
                                id: blurHPassTexture
                                width: root.width
                                height: root.height
                                format: Texture.RGBFormat
                                generateMipMaps: false
                                magnificationFilter: Texture.Linear
                                minificationFilter: Texture.Linear
                                wrapMode {
                                    x: WrapMode.ClampToEdge
                                    y: WrapMode.ClampToEdge
                                }
                            }
                        }
                    ]
                }
            }
        }

        RenderPassFilter {
            matchAny: [ FilterKey { name: "pass"; value: "blur" } ]

            parameters: [
                Parameter { name: "texMap"; value: blurHPassTexture },
                Parameter { name: "hvSelector"; value: Qt.vector2d(0, 1) }
            ]

            RenderTargetSelector {
                target: RenderTarget {
                    attachments: [
                        RenderTargetOutput {
                            attachmentPoint: RenderTargetOutput.Color0
                            texture: Texture2D {
                                id: blurVPassTexture
                                width: root.width
                                height: root.height
                                format: Texture.RGBFormat
                                generateMipMaps: false
                                magnificationFilter: Texture.Linear
                                minificationFilter: Texture.Linear
                                wrapMode {
                                    x: WrapMode.ClampToEdge
                                    y: WrapMode.ClampToEdge
                                }
                            }
                        }
                    ]
                }
            }
        }

        RenderPassFilter {
            matchAny: [ FilterKey { name: "pass"; value: "combine" } ]

            parameters: [
                Parameter { name: "blurTexMap"; value: blurVPassTexture },
                Parameter { name: "modelTexMap"; value: modelPassColorTexture }
            ]

            ClearBuffers {
                buffers: ClearBuffers.DepthBuffer
            }
        }
    }
}
