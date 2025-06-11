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