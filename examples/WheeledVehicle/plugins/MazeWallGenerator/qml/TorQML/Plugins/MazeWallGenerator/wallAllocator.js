function allocateVertWall(){
    var w = _generator.width();
    var h = _generator.height();
    for(var y = 0; y < h; y++){
        for(var x = 0; x < w; x++){
            if(_generator.has_vert_wall(x, y)){
                _vertwall.createObject(parent, {'x': x * 180 + 90, 'y': y * 180});
            }
        }
    }
    for(var y = 0; y < h; y++){
        _vertwall.createObject(parent, {'x': -90, 'y': y * 180});
        _vertwall.createObject(parent, {'x': w * 180-90, 'y': y * 180});
    }
}

function allocateHorizWall(){
    var w = _generator.width();
    var h = _generator.height();
    for(var y = 0; y < h; y++){
        for(var x = 0; x < w; x++){
            if(_generator.has_horiz_wall(x, y)){
                _horizwall.createObject(parent, {'x': x * 180, 'y': y * 180 - 90});
            }
        }
    }
    for(var x = 0; x < w; x++){
        _horizwall.createObject(parent, {'x': x * 180, 'y': h * 180 - 90});
        _horizwall.createObject(parent, {'x': x * 180, 'y': -90});
    }
}

function prepare(){
    _generator.prepare_data();
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
}

// vim:set ts=4 sw=4 et:
