import Qt3D 2.0           // For Light component
import TorQML 0.1
import TorQML.Shapes 0.1
import TorQML.Views 0.1

TQBasicView {
    light: Light {
        position: "0,0,5"
        ambientColor: "white"
    }
    camera: TQCamera {
        center: "0,0,1"
        eye: "8,8,8"
    }

    models: MyModel{ }
}
