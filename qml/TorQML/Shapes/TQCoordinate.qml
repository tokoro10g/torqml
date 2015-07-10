import QtQuick 2.0
import Qt3D 2.0
import Qt3D.Renderer 2.0
//import TorQML.Shapes 1.0

Entity {
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
        transform: Transform {
            Rotate { angle: 90; axis: "0,0,1" }
        }
    }
    TQAxis {
        id: zAxis
        color: "blue"
        transform: Transform {
            Rotate { angle: -90; axis: "0,1,0" }
        }
    }
}

// vim:set ts=4 sw=4 et:
