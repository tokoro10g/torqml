import QtQuick 2.0
import Qt3D 2.0
import "mouseEventHandler.js" as MouseEventHandler

Viewport {
    id: _viewport
    width: parent.width; height: parent.height
    light: Light {
        position: "50,80,50"
        ambientColor: "white"
    }
    fovzoom: true
    focus: true
    anchors.fill: parent
    camera: TQCamera {}
    MouseArea {
        id: _mouseArea
        property bool rotating: false
        property bool translating: false
        property int startX: 0
        property int startY: 0
        property variant startEye
        property variant startCenter
        property variant startUpVector
        anchors.fill: parent
        onPressed: {
            MouseEventHandler.onPressed(mouse);
        }
        onReleased: {
            MouseEventHandler.onReleased(mouse);
        }
        onPositionChanged: {
            MouseEventHandler.onPositionChanged(mouse);
        }
        onWheel: {
            MouseEventHandler.onWheel(wheel);
        }
    }
}

// vim:set ts=4 sw=4 et:
