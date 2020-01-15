import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.0

Entity {
    id: root

    property real threshold: 1.0
    property real gamma: 2.2
    property real exposure: 1.0

    components: [
        BloomFrameGraph {}
    ]

    Model {
        threshold: root.threshold
    }

    Bloom {
        gamma: root.gamma
        exposure: root.exposure
    }
}
