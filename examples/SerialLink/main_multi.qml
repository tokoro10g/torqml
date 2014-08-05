import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Window 2.1
import Qt3D 2.0
import TorQML.DataSources 0.1
import TorQML.Views 0.1

TQBasicView {
    id: controller

    camera: TQCamera {
        center: "0,0,0"
        eye: "0,0,7"
    }

    msPerFrame: 20

    models: [
        SerialLink {
            id: links1
            dataSource: TQLinearDataSource {
                onDataTriggered: {
                    links1.theta1 = value_at(0) * 180 / Math.PI
                    links1.theta2 = value_at(0) * 180 / Math.PI
                }
            }
        },
        SerialLink {
            id: links2
            dataSource: TQLinearDataSource {
                onDataTriggered: {
                    links2.theta1 = value_at(0) * 90 / Math.PI + 90
                    links2.theta2 = value_at(0) * 90 / Math.PI
                }
            }
        }
    ]
}

// vim:set ts=4 sw=4 et:
