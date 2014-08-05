import QtQuick 2.0
import Qt3D 2.0
import Qt3D.Shapes 2.0
import TorQML.Shapes 0.1

TQPrimitive {
    id: _obj
    property real radius: 1
    property alias length: _obj.xLength

    yWidth: radius
    zDepth: radius

    mesh: Mesh { source: "../../../assets/shapes/TQCone.obj" }
}

// vim:set ts=4 sw=4 et:
