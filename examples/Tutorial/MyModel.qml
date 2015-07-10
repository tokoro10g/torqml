import Qt3D 2.0
import TorQML 0.1
import TorQML.Shapes 0.1

TQModel {
    property alias theta1: _theta1.angle
    property alias theta2: _theta2.angle

    TQBox {
        xLength: 0.5
        yWidth: 0.3
        zDepth: 0.3
        TQBox {
            xLength: 1.0
            yWidth: 0.3
            zDepth: 0.3
            color: "blue"
            transform: Transform {
                Rotate { id: _theta1; angle: 30; axis: "0,0,1" }
            }
            TQBox {
                xLength: 0.5
                yWidth: 0.3
                zDepth: 0.3
                color: "green"
                transform: Transform {
                    Rotate { id: _theta2; angle: 30; axis: "0,0,1" }
                }
            }
        }
    }
}

// vim:set ts=4 sw=4 et:
