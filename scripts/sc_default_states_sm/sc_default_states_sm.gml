
function set_state_by_side(_side){
    if(_side == 0){
        if(right){
            state = CHARACTER_STATE.MOVING_FORWARD;
        }
        if(left){
            state = CHARACTER_STATE.MOVING_BACKWARD;
        }
    }
    if(_side == 1){
        if(right){
            state = CHARACTER_STATE.MOVING_BACKWARD;
        }
        if(left){
            state = CHARACTER_STATE.MOVING_FORWARD;
        }
    }
}

function default_base_state(){
    hspd = 0;
    state = CHARACTER_STATE.IDLE;
}

function default_idle_state(){
    
    set_state_by_side(player_num);
}

function default_moving_forward_state(){
    var _dir = point_direction(0,0,(right-left),(down-up));
    hspd = lengthdir_x(spd,_dir);
    
    set_state_by_side(player_num);
    if(!is_moving){
        state = CHARACTER_STATE.BASE;
    }
}

function default_moving_backward_state(){
    var _dir = point_direction(0,0,(right-left),(down-up));
    hspd = lengthdir_x(spd,_dir);
    
    set_state_by_side(player_num);
    if(!is_moving){
        state = CHARACTER_STATE.BASE;
    }
}

function default_crouched_state(){
    
}

function default_on_air_state(){
    
}

// Default Attacks

function default_heavy_attack_state(){
    
}

function default_light_attack_state(){
    
}

function default_heavy_kick_state(){
    
}

function default_light_kick_state(){
    
}

function default_crouched_attack_state(){
    
}

function default_crouched_kick_state(){
    
}

function default_air_attack_state(){
    
}

function default_air_kick_state(){
    
}