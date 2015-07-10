import QtQuick 2.0
import Qt3D 2.0
import Qt3D.Renderer 2.0
import QtQuick.Scene3D 2.0
import TorQML.Shapes 0.1

Scene3D {
    property var camera: TQCamera {}
    property PointLight light: PointLight {
        position: "50,80,50"
        color: "white"
        intensity: 4.0
    }
    id: _sceneRoot
    width: parent.width; height: parent.height
    property alias models: _scene.data
    focus: true
    anchors.fill: parent
    Entity {
        id: _scene
        Configuration { controlledCamera: camera2 }
        // TODO: Fix this dirty workaround
        Camera {
            id: camera2
            projectionType: camera.projectionType
            aspectRatio: camera.aspectRatio
            fieldOfView: camera.fieldOfView
            position: camera.position; viewCenter: camera.viewCenter; upVector: camera.upVector
            nearPlane: camera.nearPlane; farPlane: camera.farPlane
            right: camera.right; left: camera.left; top: camera.top; bottom: camera.bottom
        }
        components: [
            FrameGraph {
                activeFrameGraph: ForwardRenderer {
                    clearColor: "black"
                    camera: camera2
                }
            }
        ]
    }
}

// vim:set ts=4 sw=4 et:
