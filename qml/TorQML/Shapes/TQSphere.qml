import QtQuick 2.0
import Qt3D 2.0
import Qt3D.Shapes 2.0
import TorQML.Shapes 0.1

TQPrimitive {
    id: _obj
    property real radius: 1

    xLength: radius
    yWidth: radius
    zDepth: radius
    centered: true

    mesh: Mesh { source: "../../../assets/shapes/TQSphere.obj" }
}

// vim:set ts=4 sw=4 et:
