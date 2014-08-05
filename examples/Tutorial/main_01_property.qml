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
            color: "green" // Hex format is also allowed: "#00FF00"
        }
    }
}
