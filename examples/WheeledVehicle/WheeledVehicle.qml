import QtQuick 2.0
import Qt3D 2.0
import TorQML 0.1
import TorQML.Shapes 0.1
import TorQML.Plugins.MazeWallGenerator 0.1

TQModel {
    property real tx
    property real ty
    property alias theta: _theta.angle
    property alias wallSource: _wall.source
    TQGrid{
        step: 180
        size: 1800
        position: Qt.vector3d(180*8, 180*8, 0);
    }
    Entity {
        TQBox {
            xLength: 60
            yWidth: 90
            zDepth: 10
            centered: true
            color: "yellow"
        }
        TQCylinder {
            radius: 12
            length: 11
            centered: true
            color: "red"
            transform: Transform {
                Translate { translation: "30,-20,0" }
            }
        }
        TQCylinder {
            radius: 12
            length: 11
            centered: true
            color: "red"
            transform: Transform {
                Translate { translation: "-30,-20,0" }
            }
        }
        components: Transform {
            Rotate {
                id: _theta
                angle: 0
                axis: "0,0,1"
            }
            Translate {
                id: _body
                translation: Qt.vector3d(tx, ty, 0)
            }
        }
    }

    MazeWallGenerator{
        id: _wall
    }
}

// vim:set ts=4 sw=4 et:
