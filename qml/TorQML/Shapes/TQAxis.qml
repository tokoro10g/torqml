import QtQuick 2.0
import Qt3D 2.0
import Qt3D.Shapes 2.0
import TorQML.Shapes 0.1

Item3D {
    id: _obj
    property real cylinderRadius: 0.1
    property real cylinderLength: 0.7
    property real coneRadius: 0.2
    property real coneLength: 0.3
    property alias color: _cylinder.color

    TQCylinder {
        id: _cylinder
        radius: cylinderRadius
        length: cylinderLength
        TQCone {
            radius: coneRadius
            length: coneLength
            color: _cylinder.color
        }
    }
}

// vim:set ts=4 sw=4 et:
