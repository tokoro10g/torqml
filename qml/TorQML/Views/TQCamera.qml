import QtQuick 2.0
import Qt3D 2.0

Camera {
    projectionType: CameraLens.PerspectiveProjection
    aspectRatio: 4/3
    viewCenter: "0,0,0"
    position: "8,5,5"
    upVector: "0,1,0"
    nearPlane: 0.01
    farPlane: 1000.0
    fieldOfView: 30
}

// vim:set ts=4 sw=4 et:
