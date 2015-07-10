import QtQuick 2.0
import Qt3D 2.0
import TorQML.Shapes 0.1

Entity {
    property real x : 0
    property real y : 0
    TQBox {
        xLength: 180
        yWidth: 12
        zDepth: 48
        centered: true
        color: "white"
    }
    TQBox {
        xLength: 180
        yWidth: 12
        zDepth: 2
        centered: true
        color: "red"
        transform: Transform {
            Translate { translation: "0,0,24" }
        }
    }
    components: Transform {
        Translate { translation: Qt.vector3d(x,y,25) }
    }
}

// vim:set ts=4 sw=4 et:
