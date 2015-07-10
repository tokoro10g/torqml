import Qt3D 2.0
import TorQML 0.1
import TorQML.Shapes 0.1
import TorQML.Views 0.1

TQBasicView {
    models: TQModel {
        TQBox {
            // Dimensions
            xLength: 1.0
            yWidth: 0.3
            zDepth: 0.3
            transform: Transform {
                Rotate { angle: 30; axis: "0,0,1" }
                Translate { translation: "1,0,0" }
            }
        }
    }
}
