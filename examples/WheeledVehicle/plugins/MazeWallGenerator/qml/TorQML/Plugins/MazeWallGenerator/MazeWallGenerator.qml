import QtQuick 2.0
import Qt3D 2.0
import TorQML.Plugins.MazeWallGenerator 0.1
import "wallAllocator.js" as WallAllocator

Entity {
    property alias source: _generator.source
    MazeWallGenerator_ {
        id: _generator
        Component.onCompleted: {
            WallAllocator.prepare();
        }
    }
    Component {
        id: _vertwall
        MazeVertWall{}
    }
    Component {
        id: _horizwall
        MazeHorizWall{}
    }
    Entity {
        id: walls
    }
}

// vim:set ts=4 sw=4 et:
