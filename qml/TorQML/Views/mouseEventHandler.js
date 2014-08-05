function onPressed(mouse) {
    _viewport.focus = true;
    if (mouse.button == Qt.LeftButton) {
        _mouseArea.startX = mouse.x;
        _mouseArea.startY = mouse.y;
        _mouseArea.startEye = _viewport.camera.eye;
        _mouseArea.startCenter = _viewport.camera.center;
        _mouseArea.startUpVector = _viewport.camera.upVector;
        if (mouse.modifiers & Qt.ShiftModifier) {
            _mouseArea.translating = true;
        } else {
            _mouseArea.rotating = true;
        }
    }
}

function onReleased(mouse) {
    if (mouse.button == Qt.LeftButton) {
        _mouseArea.rotating = false;
        _mouseArea.translating = false;
    }
}

function onPositionChanged(mouse) {
    var deltaX = mouse.x - _mouseArea.startX;
    var deltaY = mouse.y - _mouseArea.startY;
    if (_mouseArea.rotating) {
        var angleAroundY = deltaX * 90 / _mouseArea.width;
        var angleAroundX = deltaY * 90 / _mouseArea.height;
        _viewport.camera.eye = _mouseArea.startEye;
        _viewport.camera.center = _mouseArea.startCenter;
        _viewport.camera.upVector = _mouseArea.startUpVector;
        _viewport.camera.tiltPanRollCenter(-angleAroundX, -angleAroundY, 0);
    } else if (_mouseArea.translating) {
        var e = _mouseArea.startEye.minus(_mouseArea.startCenter);
        var e3 = e.normalized();
        var e2 = _mouseArea.startUpVector.normalized();
        var e1 = e2.crossProduct(e3);
        var deltaE1 = deltaX * e.length() * 0.5 / _mouseArea.width;
        var deltaE2 = deltaY * e.length() * 0.5 / _mouseArea.height;
        var afterEye = _mouseArea.startEye.minus(e1.times(deltaE1)).plus(e2.times(deltaE2));
        var afterCenter = _mouseArea.startCenter.minus(e1.times(deltaE1)).plus(e2.times(deltaE2));
        _viewport.camera.eye = afterEye;
        _viewport.camera.center = afterCenter;
    }
}

function onWheel(wheel) {
    var delta = wheel.angleDelta.y / 2000;
    var e = _viewport.camera.eye;
    var afterEye = e.minus(e.times(delta));
    _viewport.camera.eye = afterEye;
}

// vim:set ts=4 sw=4 et:
