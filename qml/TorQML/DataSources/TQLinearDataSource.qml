import QtQuick 2.0
import TorQML.DataSources 0.1

// registered component by lineardatasource.rb
LinearDataSource_rb {
    id: _dataSource
    dataSize: 100
    dataStep: 0.1
    currentFrame: -1
    onDataTriggered: {
    }
    Component.onCompleted: {
        _dataSource.prepare_data()
        _dataSource.currentFrame = 1
    }
}

// vim:set ts=4 sw=4 et:
