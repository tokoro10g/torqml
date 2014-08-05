import QtQuick 2.0
import Qt3D 2.0
import TorQML 0.1
import TorQML.Shapes 0.1

TQModel {
    property alias theta1: _theta1.angle
    property alias theta2: _theta2.angle
    TQGrid {
        step: 0.1
        size: 2
    }
    TQBox {
        id: _link1
        xLength: 0.5
        yWidth: 0.1
        zDepth: 0.1
        color: "#ff0000"
        transform: [
            Rotation3D { id: _theta1; angle: 0; axis: "0,0,1" }
        ]
        TQBox {
            id: _link2
            xLength: 0.5
            yWidth: 0.1
            zDepth: 0.1
            color: "#0000ff"
            transform: [
                Rotation3D { id: _theta2; angle: 0; axis: "0,0,1" }
            ]
        }
    }
}

// vim:set ts=4 sw=4 et:
