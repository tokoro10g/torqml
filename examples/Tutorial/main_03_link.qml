import Qt3D 2.0
import TorQML 0.1
import TorQML.Shapes 0.1
import TorQML.Views 0.1

TQBasicView {
    models: TQModel {
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
                    Rotate { angle: 30; axis: "0,0,1" }
                }
                TQBox {
                    xLength: 0.5
                    yWidth: 0.3
                    zDepth: 0.3
                    color: "green"
                    transform: Transform {
                        Rotate { angle: 30; axis: "0,0,1" }
                    }
                }
            }
        }
    }
}
