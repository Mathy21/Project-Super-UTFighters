///@method animation_start(sprite_asset,[mask]);
function animation_start(_sprite){
    var _mask;
    if(sprite_index != _sprite){
        image_index = 0;
        if(argument_count > 1){
           _mask = argument[1];
        }
            else{
                _mask = _sprite;
            }
        sprite_index = _sprite;
        mask_index = _mask;
    }
}

function animation_end(){
	var _sprite, _index;
	_sprite = sprite_index;
	_index = image_index;
	
	var _speed, _type;
	_speed = sprite_get_speed(_sprite)*image_speed;
	_type = sprite_get_speed_type(_sprite);
	if(_type == spritespeed_framespersecond){
		_speed /= game_get_speed(gamespeed_fps);
	}
	
	return _index + _speed >= sprite_get_number(_sprite);
}