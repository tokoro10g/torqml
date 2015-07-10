import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Window 2.1
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2

Window {
    id: _progressDialog
    title: "Exporting..."
    width: 300
    height: 80
    flags: Qt.Dialog
    modality: Qt.WindowModal
    property alias minimumValue: _progress.minimumValue
    property alias maximumValue: _progress.maximumValue
    property alias value: _progress.value

    SystemPalette{ id: _palette }
    color: _palette.window

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 5
        ProgressBar {
            Layout.fillWidth: true
            id: _progress
        }
        Button {
            Layout.fillWidth: true
            text: "Abort"
            onClicked: { _progressDialog.close(); }
        }
    }
}

// vim:set ts=4 sw=4 et:
