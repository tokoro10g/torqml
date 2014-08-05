import TorQML 0.1
import TorQML.Shapes 0.1
import TorQML.Views 0.1
import TorQML.DataSources 0.1

TQBasicView {
    msPerFrame: 20

    models: MyModel {
        id: model
        dataSource: TQLinearDataSource {
            onDataTriggered: {
                model.theta1 = value_at(0) * 5
                model.theta2 = value_at(0) * 5
            }
        }
    }
}
