import QtQuick 2.0
import Qt3D 2.0
import Qt3D.Renderer 2.0
//import TorQML.Shapes 1.0

Entity {
    id: _obj
    property real step: 1.0
    property real size: 10
    property var position: "0,0,0"
    property string color: "#33FFFFFF"
    NodeInstantiator {
        model: _obj.size / _obj.step * 2 + 1
        delegate: TQCylinder {
            radius: _obj.step / 20
            length: _obj.size * 2
            centered: true
            position: Qt.vector3d(0, _obj.step * index - _obj.size, 0)
            color: _obj.color
        }
    }
    NodeInstantiator {
        model: _obj.size / _obj.step * 2 + 1
        delegate: TQCylinder {
            radius: _obj.step / 20
            length: _obj.size * 2
            centered: true
            position: Qt.vector3d(_obj.step * index - _obj.size, 0, 0)
            transform: Transform {
                Rotate { angle: 90; axis: "0,0,1" }
            }
            color: _obj.color
        }
    }
    components: Transform { 
        Translate { translation: position }
    }
}

// vim:set ts=4 sw=4 et:
