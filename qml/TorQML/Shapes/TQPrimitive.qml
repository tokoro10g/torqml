import QtQuick 2.0
import Qt3D 2.0
import Qt3D.Renderer 2.0

Entity {
    property real xLength: 1
    property real yWidth: 1
    property real zDepth: 1
    property bool centered: false
    property string color: "red"
    property real opacity: 1.0
    //property Texture texture: Texture{}
    property var mesh: CuboidMesh{}
    property Material material: PhongMaterial {
        id: material
        ambient: "black"
        diffuse: color
        specular: "black"
        Parameter {
            name: "opacity"
            value: opacity
        }
    }
    property var position: "0,0,0"
    property Transform transform: Transform{}

    id: primitive

    Entity {
        id: entity
        Transform {
            id: shapetransform
            Scale { scale3D: Qt.vector3d(xLength, yWidth, zDepth) }
            Translate { translation: Qt.vector3d( centered ? -xLength / 2 : 0, 0, 0) }
        }
        components: [mesh, material, shapetransform]
    }
    Transform {
        id: posttransform
        MatrixTransform {
            matrix: transform.matrix
        }
        Translate { translation: position }
    }
    components: [posttransform]

    Component.onCompleted: {
        var children = primitive.data;
        for(var i = 0; i < children.length; i++) {
            if("position" in children[i]){
                children[i].position = Qt.vector3d( xLength / ( centered ? 2 : 1 ), 0, 0);
            }
        }
    }
}

// vim:set ts=4 sw=4 et:
