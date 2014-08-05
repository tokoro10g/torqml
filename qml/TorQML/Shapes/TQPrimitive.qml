import QtQuick 2.0
import Qt3D 2.0

Item3D {
    property real xLength: 1
    property real yWidth: 1
    property real zDepth: 1
    property bool centered: false
    property alias color: _effect.color
    property alias texture: _effect.texture

    property alias mesh: _obj.mesh

    Item3D {
        id: _obj
        effect: Effect {
            id: _effect
            blending: true
            color: "red"
        }
        transform: [
            Scale3D { scale: Qt.vector3d(xLength, yWidth, zDepth) },
            Translation3D { translate: Qt.vector3d( centered ? -xLength / 2 : 0, 0, 0) }
        ]
    }
    Component.onCompleted: {
        if("xLength" in parent){
            position = Qt.vector3d( parent.xLength / ( parent.centered ? 2 : 1 ), 0, 0)
        }
    }
}

// vim:set ts=4 sw=4 et:
