import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Scene3D 2.12

Window {
    visible: true
    width: 512
    height: 512
    title: qsTr("Hello World")

    Scene3D {
        id: scene3d
        anchors.fill: parent
        focus: true
        aspects: ["input", "logic"]
        cameraAspectRatioMode: Scene3D.AutomaticAspectRatio

        SceneRoot {
            id: root
        }
    }
}
