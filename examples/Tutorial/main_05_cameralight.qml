import Qt3D.Renderer 2.0           // For Light component
import TorQML 0.1
import TorQML.Shapes 0.1
import TorQML.Views 0.1

TQBasicView {
    light: PointLight {
        position: "0,0,5"
        color: "white"
    }
    camera: TQCamera {
        viewCenter: "0,0,1"
        position: "8,8,8"
    }

    models: MyModel{ }
}
