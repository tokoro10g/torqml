function allocateVertWall(){
    var w = _generator.width();
    var h = _generator.height();
    for(var y = 0; y < h; y++){
        for(var x = 0; x < w; x++){
            if(_generator.has_vert_wall(x, y)){
                _vertwall.createObject(walls, {'x': x * 180 + 90, 'y': y * 180});
                console.log("creating MazeVertWall at " + (x*180+90) + "," + (y*180));
            }
        }
    }
    for(var y = 0; y < h; y++){
        _vertwall.createObject(walls, {'x': -90, 'y': y * 180});
        console.log("creating MazeVertWall at " + (-90) + "," + (y*180));
        _vertwall.createObject(walls, {'x': w * 180-90, 'y': y * 180});
        console.log("creating MazeVertWall at " + (w*180-90) + "," + (y*180));
    }
}

function allocateHorizWall(){
    var w = _generator.width();
    var h = _generator.height();
    for(var y = 0; y < h; y++){
        for(var x = 0; x < w; x++){
            if(_generator.has_horiz_wall(x, y)){
                _horizwall.createObject(walls, {'x': x * 180, 'y': y * 180 - 90});
                console.log("creating MazeHorizWall at " + (x*180) + "," + (y*180-90));
            }
        }
    }
    for(var x = 0; x < w; x++){
        _horizwall.createObject(walls, {'x': x * 180, 'y': h * 180 - 90});
        console.log("creating MazeHorizWall at " + (x*180) + "," + (h*180-90));
        _horizwall.createObject(walls, {'x': x * 180, 'y': -90});
        console.log("creating MazeHorizWall at " + (x*180) + "," + (-90));
    }
}

function prepare(){
    _generator.prepare_data();
    console.log("parentNode:" + walls);
    if(_vertwall.status === Component.Ready){
        allocateVertWall();
    } else {
        _vertwall.statusChanged.connect(allocateVertWall);
    }
    if(_horizwall.status === Component.Ready){
        allocateHorizWall();
    } else {
        _horizwall.statusChanged.connect(allocateHorizWall);
    }
    console.log("prepare() completed");
}

// vim:set ts=4 sw=4 et:
