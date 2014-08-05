import QtQuick 2.0
import Qt3D 2.0
import Qt3D.Shapes 2.0
import TorQML.Shapes 0.1

Item3D {
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
        transform: [
            Translation3D { translate: "0,0,24" }
        ]
    }
    transform: [
        Translation3D { translate: "0,0,25" },
        Rotation3D { angle: 90; axis: "0,0,1" }
    ]
}

// vim:set ts=4 sw=4 et:
