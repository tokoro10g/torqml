import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Window 2.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.1

Window {
    id: _captureDialog
    title: "Capture frames"
    width: 500
    height: 450
    flags: Qt.Dialog
    modality: Qt.WindowModal
    property real maxFrame: 1
    property string returnValue: ""
    property alias frameWidth: _frameWidth.value
    property alias frameHeight: _frameHeight.value

    SystemPalette{ id: _palette }
    color: _palette.window

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        GroupBox {
            Layout.fillWidth: true
            title: "Format"
            RowLayout {
                anchors.fill: parent
                ExclusiveGroup{ id: _formatGroup }
                RadioButton {
                    id: _formatPng
                    text: "png"
                    checked: true
                    exclusiveGroup: _formatGroup
                }
                RadioButton {
                    id: _formatMp4
                    text: "mp4"
                    exclusiveGroup: _formatGroup
                    enabled: false
                }
            }
        }
        GroupBox {
            Layout.fillWidth: true
            title: "Dimension"
            RowLayout {
                SpinBox {
                    id: _frameWidth
                    minimumValue: 1
                    maximumValue: 2048
                }
                Label { text: " x " }
                SpinBox {
                    id: _frameHeight
                    minimumValue: 1
                    maximumValue: 2048
                }
                Label { text: " px" }
            }
        }
        GroupBox {
            Layout.fillWidth: true
            title: "Frame Range"
            ColumnLayout {
                anchors.fill: parent
                ExclusiveGroup{ id: _rangeGroup }
                RadioButton {
                    id: _rangeCurrent
                    text: "Current frame"
                    exclusiveGroup: _rangeGroup
                }
                RadioButton {
                    id: _rangeAll
                    text: "All frames"
                    checked: true
                    exclusiveGroup: _rangeGroup
                }
                RowLayout {
                    RadioButton {
                        id: _rangeCustom
                        text: "Custom range : "
                        exclusiveGroup: _rangeGroup
                        onCheckedChanged: { _rangeFrom.enabled = checked; _rangeTo.enabled = checked; }
                    }
                    SpinBox {
                        id: _rangeFrom
                        minimumValue: 1
                        maximumValue: maxFrame
                        enabled: false
                        value: 1
                    }
                    Label { text: "-" }
                    SpinBox {
                        id: _rangeTo
                        minimumValue: 1
                        maximumValue: maxFrame
                        enabled: false
                        value: maxFrame
                    }
                }
                RowLayout {
                    Label { text: "Frame skip : " }
                    SpinBox {
                        id: _rangeFrameSkip
                        minimumValue: 0
                        maximumValue: maxFrame
                        value: 0
                    }
                }
            }
        }
        GroupBox {
            Layout.fillWidth: true
            title: "Directory"
            RowLayout {
                anchors.fill: parent
                TextField {
                    id: _pathDir
                    Layout.fillWidth: true
                }
                Button {
                    text: "..."
                    FileDialog {
                        id: _pathDialog
                        title: "Select a directory"
                        folder: ""
                        selectFolder: true
                        selectExisting: true
                        // FIXME: QImage::save does not accept canonical urls
                        onAccepted: { _pathDir.text = _pathDialog.fileUrls.toString().replace("file://", ""); }
                    }
                    onClicked: { _pathDialog.open(); }
                    // FIXME: QImage::save does not accept canonical urls
                    Component.onCompleted: { _pathDir.text = _pathDialog.folder.toString().replace("file://", ""); }
                }
            }
        }
        GroupBox {
            Layout.fillWidth: true
            title: "Prefix"
            TextField {
                id: _prefix
                anchors.fill: parent
                Layout.fillWidth: true
                text: "frame_"
            }
        }
        RowLayout {
            Layout.alignment: Qt.AlignRight
            Button {
                text: "Ok"
                onClicked: {
                    if(_rangeCustom.checked && _rangeFrom.value > _rangeTo.value) {
                        _alertDialog.text = "Invalid frame range!";
                        _alertDialog.open();
                        return;
                    }
                    var returnObject = {
                        "format": (_formatPng.checked ? "png" : "") + (_formatMp4.checked ? "mp4" : ""),
                        "dimension": {
                            "width": _frameWidth.value,
                            "height": _frameHeight.value
                        },
                        "range": {
                            "mode": (_rangeCurrent.checked ? "current" : "") + (_rangeAll.checked ? "all" : "") + (_rangeCustom.checked ? "custom" : ""),
                            "from": _rangeFrom.value,
                            "to": _rangeTo.value,
                            "frameSkip": _rangeFrameSkip.value
                        },
                        "path": {
                            "directory": _pathDir.text,
                            "prefix": _prefix.text
                        }
                    };
                    returnValue = JSON.stringify(returnObject);
                    _captureDialog.close();
                }
            }
            Button {
                text: "Cancel"
                onClicked: {
                    returnValue = "";
                    _captureDialog.close();
                }
            }
        }
        MessageDialog {
            id: _alertDialog;
            title: "Warning"
            icon: StandardIcon.Warning
        }
    }
}

// vim:set ts=4 sw=4 et:
