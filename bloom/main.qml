import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Scene3D 2.12
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 812
    height: 512
    title: qsTr("Hello World")

    Scene3D {
        id: scene3d
        x: 300
        width: 512
        height: 512
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        anchors.leftMargin: 300
        focus: true
        aspects: ["input", "logic"]
        cameraAspectRatioMode: Scene3D.AutomaticAspectRatio

        SceneRoot {
            threshold: thresholdSlider.value
            gamma: gammaSlider.value
            exposure: exposureSlider.value
        }
    }

    Slider {
        id: thresholdSlider
        x: 28
        y: 136
        from: 0
        to: 2.0
        value: 1.0
    }

    Text {
        x: 240
        y: 144
        font.pixelSize: 18
        text: thresholdSlider.value
    }

    Slider {
        id: gammaSlider
        x: 28
        y: 226
        from: 0
        to: 5.0
        value: 2.2
    }

    Text {
        x: 240
        y: 234
        font.pixelSize: 18
        text: gammaSlider.value
    }

    Slider {
        id: exposureSlider
        x: 28
        y: 328
        from: 0
        to: 2.0
        value: 1.0
    }

    Text {
        x: 240
        y: 336
        font.pixelSize: 18
        text: exposureSlider.value
    }

    Text {
        x: 38
        y: 98
        text: qsTr("threshold")
        font.pixelSize: 18
    }

    Text {
        x: 38
        y: 199
        text: qsTr("gamma")
        font.pixelSize: 18
    }

    Text {
        x: 38
        y: 301
        text: qsTr("exposure")
        font.pixelSize: 18
    }
}
