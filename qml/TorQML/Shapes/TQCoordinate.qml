import QtQuick 2.0
import Qt3D 2.0
import Qt3D.Shapes 2.0
import TorQML.Shapes 0.1

Item3D {
    property alias xColor: xAxis.color
    property alias yColor: yAxis.color
    property alias zColor: zAxis.color
    TQAxis {
        id: xAxis
        color: "red"
    }
    TQAxis {
        id: yAxis
        color: "green"
        transform: [
            Rotation3D { angle: 90; axis: "0,0,1" }
        ]
    }
    TQAxis {
        id: zAxis
        color: "blue"
        transform: [
            Rotation3D { angle: -90; axis: "0,1,0" }
        ]
    }
}

// vim:set ts=4 sw=4 et:
