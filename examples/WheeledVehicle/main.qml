import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Window 2.1
import Qt3D 2.0
import Qt3D.Renderer 2.0
import TorQML.DataSources 0.1
import TorQML.Views 0.1

TQBasicView {
    id: controller

    light: PointLight {
        position: "0,0,5000"
        color: "white"
    }
    camera: TQCamera {
        viewCenter: Qt.vector3d(8 * 180, 8 * 180, 0)
        position: Qt.vector3d(8 * 180, 8 * 180, 6000)
        farPlane: 1000000
        nearPlane: 5
    }

    msPerFrame: 5

    models: WheeledVehicle {
        id: links
        dataSource: TQCSVDataSource {
            source: "data/wheeledvehicle.csv"
            onDataTriggered: {
                links.tx = value_at(0)
                links.ty = value_at(1)
                links.theta = -value_at(2) // * 180 / Math.PI
            }
        }
        wallSource: "data/maze2014student.dat"
    }
}

// vim:set ts=4 sw=4 et:
