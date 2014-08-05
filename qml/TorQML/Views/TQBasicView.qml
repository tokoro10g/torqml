import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Window 2.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.1
import Qt3D 2.0
import TorQML.DataSources 0.1
import TorQML.FrameGrabber 0.1
import TorQML.Views.Dialogs 0.1
import "basicview.js" as BasicViewLogic

ApplicationWindow {
    property alias models: _viewport.children
    property alias numberOfFrames: _slider.maximumValue
    property alias msPerFrame: _timePerFrame.value
    property alias light: _viewport.light
    property alias camera: _viewport.camera
    id: _window
    flags: Qt.Dialog

    visible: true
    width: 640
    height: 480
    color: "black"

    title: "TorQML Viewer"

    menuBar: MenuBar {
        id: _menuBar
        Menu {
            title: "File"
            MenuItem { text: "Open..." }
            MenuItem { text: "Close" }
        }
        Menu {
            title: "Tool"
            MenuItem{ text: "hogehoge" }
        }
    }

    toolBar: ToolBar {
        id: _toolBar

        RowLayout {
            height: 34
            spacing: 5

            ToolButton {
                id: _playButton
                iconSource: "../../../assets/images/play.png"

                onClicked: {
                    if(_slider.value == numberOfFrames) _slider.value = 1;
                    _sliderTransition.start();
                }
            }
            ToolButton {
                id: _stopButton
                iconSource: "../../../assets/images/stop.png"

                onClicked: _sliderTransition.stop();
            }

            Slider {
                id: _slider
                property real from: 0
                property real to: numberOfFrames
                minimumValue: 1
                maximumValue: numberOfFrames

                onValueChanged: BasicViewLogic.updateFrame(value);
                onMaximumValueChanged: _maxFrameText.text = "/" + numberOfFrames;
                Keys.onPressed: BasicViewLogic.onKeyPressed(event);

                NumberAnimation on value {
                    id: _sliderTransition; from: _slider.from; to: _slider.to;
                    duration: _timePerFrame.value * (_slider.to - _slider.from); running:false
                }
            }
            Label {
                id: _frameText
                text: Math.floor(_slider.value)
            }
            Label { id: _maxFrameText; text: "/" + numberOfFrames }

            SpinBox {
                id: _timePerFrame
                minimumValue: 1
                value: 1

                onValueChanged: BasicViewLogic.restartTransition(value);
            }
            Label { text: "ms/f" }

            ToolButton {
                id: _reloadButton
                iconSource: "../../../assets/images/reload.png"

                onClicked: BasicViewLogic.reloadData();
            }
            ToolButton {
                id: _captureButton
                iconSource: "../../../assets/images/capture.png"

                onClicked: BasicViewLogic.showCaptureDialog();
            }
        }
    }

    statusBar: StatusBar { id: _statusBar }

    TQViewport {
        id: _viewport;
        Keys.forwardTo: [_slider]
    }

    FrameGrabber { id: _frameGrabber }

    TQProgressDialog { id: _progressDialog }
    TQCaptureDialog {
        id: _captureDialog;
        Component.onCompleted: _captureConnection.target = _captureDialog;
    }
    Connections {
        id: _captureConnection
        onVisibleChanged: BasicViewLogic.onCaptureDialogClosed();
    }

    Timer {
        id: _frameGrabberStarter;
        interval: 200;
        repeat: false;
        onTriggered: _frameGrabberTimer.start();
    }

    Timer {
        id: _frameGrabberTimer
        property variant config
        property real currentFrame
        interval: 1
        repeat: true
        onTriggered: BasicViewLogic.captureFrame();
    }

    Component.onCompleted: BasicViewLogic.initialize();
}

// vim:set ts=4 sw=4 et:
