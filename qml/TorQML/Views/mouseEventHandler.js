function onPressed(mouse) {
    _viewport.focus = true;
    if (mouse.button == Qt.LeftButton) {
        _mouseArea.startX = _mouseArea.mouseX;
        _mouseArea.startY = _mouseArea.mouseY;
        _mouseArea.startPosition = _viewport.camera.position;
        _mouseArea.startViewCenter = _viewport.camera.viewCenter;
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
    var deltaX = _mouseArea.mouseX - _mouseArea.startX;
    var deltaY = _mouseArea.mouseY - _mouseArea.startY;
    if (_mouseArea.rotating) {
        var angleAroundY = deltaX * 90 / _mouseArea.width;
        var angleAroundX = deltaY * 90 / _mouseArea.height;
        var tiltQ = tiltRotation(angleAroundX);
        var panQ = panRotation(-angleAroundY);
        var viewVector = _mouseArea.startViewCenter.minus(_mouseArea.startPosition);
        var cameraToCenter = qRotateVector(tiltQ, qRotateVector(panQ,viewVector));
        _viewport.camera.upVector = qRotateVector(tiltQ, qRotateVector(panQ,_mouseArea.startUpVector));
        _viewport.camera.position = _mouseArea.startViewCenter.minus(cameraToCenter);
        _viewport.camera.viewCenter = _mouseArea.startViewCenter;
    } else if (_mouseArea.translating) {
        var e = _mouseArea.startPosition.minus(_mouseArea.startViewCenter);
        var e3 = e.normalized();
        var e2 = _mouseArea.startUpVector.normalized();
        var e1 = e2.crossProduct(e3);
        var deltaE1 = deltaX * e.length() * 0.5 / _mouseArea.width;
        var deltaE2 = deltaY * e.length() * 0.5 / _mouseArea.height;
        var afterEye = _mouseArea.startPosition.minus(e1.times(deltaE1)).plus(e2.times(deltaE2));
        var afterCenter = _mouseArea.startViewCenter.minus(e1.times(deltaE1)).plus(e2.times(deltaE2));
        _viewport.camera.position = afterEye;
        _viewport.camera.viewCenter = afterCenter;
    }
}

function onWheel(wheel) {
    var delta = wheel.angleDelta.y / 2000;
    var e = _viewport.camera.position;
    var afterEye = e.minus(e.times(delta));
    _viewport.camera.position = afterEye;
}

function tiltRotation(angle) {
    var viewVector = _mouseArea.startViewCenter.minus(_mouseArea.startPosition);
    var v2 = viewVector.normalized();
    var xBasis = _mouseArea.startUpVector.crossProduct(v2);
    var v3 = xBasis.normalized();
    v3 = v3.times(Math.sin(-angle/2 * Math.PI / 180));
    return Qt.vector4d(v3.x, v3.y, v3.z, Math.cos(-angle/2 * Math.PI / 180)).normalized();
}

function panRotation(angle) {
    var upVector = _mouseArea.startUpVector.normalized();
    upVector = upVector.times(Math.sin(-angle/2 * Math.PI / 180));
    return Qt.vector4d(upVector.x, upVector.y, upVector.z, Math.cos(-angle/2 * Math.PI / 180)).normalized();
}

function qRotateVector(q,v) {
    var q0 = q.w, q1 = q.x, q2 = q.y, q3 = q.z;
    var ret = Qt.vector3d(0,0,0);
    ret.x = Qt.vector3d(1-2*q2*q2-2*q3*q3, 2*(q1*q1+q0*q3), 2*(q1*q3-q0*q2)).dotProduct(v);
    ret.y = Qt.vector3d(2*(q1*q2-q0*q3), 1-2*q1*q1-2*q3*q3, 2*(q2*q3+q0*q1)).dotProduct(v);
    ret.z = Qt.vector3d(2*(q1*q3+q0*q2), 2*(q2*q3-q0*q1), 1-2*q1*q1-2*q2*q2).dotProduct(v);
    return ret;
}

// vim:set ts=4 sw=4 et:
