function updateFrame() {
    if(!_viewport) return; // viewport has not initialized yet

    for(var i = 0; i < _viewport.models.length; i++){
        if("dataSource" in _viewport.models[i])
            _viewport.models[i].dataSource.currentFrame = _slider.value // update current frame
    }
    _slider.from = _slider.value;
    _frameText.text = Math.floor(_slider.value)
}

function restartTransition(value) {
    // suspend & resume transition to apply the change of time/frame value
    if(_sliderTransition.running){
        _sliderTransition.stop();
        _sliderTransition.start();
    }
}

function reloadData() {
    var min = -1;
    for(var i = 0; i < _viewport.models.length; i++){
        if("dataSource" in _viewport.models[i]){
            _viewport.models[i].dataSource.prepare_data();
            var n = _viewport.models[i].dataSource.rows();
            // use minimum number as the maximum frame number
            if(min <= 0) min = n;
            else min = Math.min(min, n);
        }
    }
    // FIXME: what if `min` is still negative here?
    console.log("Loaded " + min + " frames");
    numberOfFrames = min;
    _slider.value = 1;
}

function showCaptureDialog() {
    // stop before proceeding
    _sliderTransition.stop();

    _captureDialog.frameWidth = _viewport.width;
    _captureDialog.frameHeight = _viewport.height;
    _captureDialog.maxFrame = numberOfFrames;
    _captureDialog.show();
}

function onCaptureDialogClosed() {
    var target = _captureConnection.target;
    if(target.visible) return;

    // closed with OK button
    if(target.returnValue){
        var config = JSON.parse(target.returnValue);
        _window.width = config.dimension.width + _window.width - _viewport.width;
        _window.height = config.dimension.height + _window.height - _viewport.height;

        // preset frame range
        if(config.range.mode == "current"){
            config.range.from = config.range.to = _slider.value;
        } else if(config.range.mode == "all"){
            config.range.from = 1;
            config.range.to = numberOfFrames;
        }

        // show a dialog to display the progress of exporting
        _progressDialog.minimumValue = config.range.from;
        _progressDialog.maximumValue = config.range.to;
        _progressDialog.show();

        // set configs and initial value, then delegate bootstrap to `_frameGrabberStarter`
        _frameGrabberTimer.config = config;
        _frameGrabberTimer.currentFrame = config.range.from;
        _frameGrabberStarter.start();
    }
}

function shouldFinish() {
    var config = _frameGrabberTimer.config;

    if(_frameGrabberTimer.currentFrame > config.range.to){
        // finish exporting
        _progressDialog.close();
        _frameGrabberTimer.stop();
        return true;
    }

    // abort exporting
    if(!_progressDialog.visible) return true;

    return false;
}

function captureFrame() {
    if(shouldFinish()) return;

    var config = _frameGrabberTimer.config;

    // update values and capture a frame
    _slider.value = _frameGrabberTimer.currentFrame;
    _progressDialog.value = _frameGrabberTimer.currentFrame;

    var filePath = config.path.directory + "/" + config.path.prefix + _frameGrabberTimer.currentFrame + ".png";
    _frameGrabber.capture(
            filePath,
            0, _window.height - _viewport.height - _statusBar.height,
            _viewport.width, _viewport.height
            );
    _frameGrabberTimer.currentFrame += config.range.frameSkip + 1;
}

function onKeyPressed(event) {
    // offers vim-like motion + arrow keys
    event.accepted = true;
    switch(event.key){
        case Qt.Key_Left:
        case Qt.Key_H:
            if(_sliderTransition.running) _sliderTransition.stop();
            _slider.value--;
            break;
        case Qt.Key_Right:
        case Qt.Key_L:
            if(_sliderTransition.running) _sliderTransition.stop();
            _slider.value++;
            break;
        case Qt.Key_W:
            if(_sliderTransition.running) _sliderTransition.stop();
            if(event.modifiers & Qt.ShiftModifier){
                _slider.value += 40;
            } else {
                _slider.value += 10;
            }
            break;
        case Qt.Key_B:
            if(_sliderTransition.running) _sliderTransition.stop();
            if(event.modifiers & Qt.ShiftModifier){
                _slider.value -= 40;
            } else {
                _slider.value -= 10;
            }
            break;
        case Qt.Key_G:
            if(_sliderTransition.running) _sliderTransition.stop();
            if(event.modifiers & Qt.ShiftModifier){
                _slider.value = numberOfFrames;
            } else {
                _slider.value = 1;
            }
            break;
        default:
            event.accepted = false;
            break;
    }
}

function initialize() {
    // adjust window size to fix the size of viewport
    _window.width -= _viewport.width;
    _window.height -= _viewport.height;

    // to avoid pointing out of bound, use the least value of frame numbers as the number of frames
    var min = -1;
    for(var i = 0; i < _viewport.models.length; i++){
        if("dataSource" in _viewport.models[i]){
            _viewport.models[i].dataSource.prepare_data();
            var n = _viewport.models[i].dataSource.rows();
            if(min < 0) min = n;
            else min = Math.min(min, n);
        }
    }
    console.log("Loaded " + min + " frames");
    numberOfFrames = min;
}

// vim:set ts=4 sw=4 et:
