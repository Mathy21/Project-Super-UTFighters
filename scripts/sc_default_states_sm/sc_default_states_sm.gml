
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
    animation_start(character.s_idle);
    set_state_by_side(player_num);
    
    if(down){
        state = CHARACTER_STATE.CROUCHED;
    }
    if(light_atk){
        state = CHARACTER_STATE.LIGHT_ATTACK;
    }
}

function default_moving_forward_state(){
    animation_start(character.s_forward);
    var _dir = point_direction(0,0,(right-left),(down-up));
    hspd = lengthdir_x(character.spd,_dir);
    
    set_state_by_side(player_num);
    if(!is_moving){
        state = CHARACTER_STATE.BASE;
    }
    if(down){
        state = CHARACTER_STATE.CROUCHED;
    }
}

function default_moving_backward_state(){
    animation_start(character.s_backward);
    var _dir = point_direction(0,0,(right-left),(down-up));
    hspd = lengthdir_x(character.spd,_dir);
    
    set_state_by_side(player_num);
    if(!is_moving){
        state = CHARACTER_STATE.BASE;
    }
    if(down){
        state = CHARACTER_STATE.CROUCHED;
    }
}

function default_crouched_state(){
    animation_start(character.s_crouched);
    hspd = 0;
    vspd = 0;
    
    if(down_release){
        state = CHARACTER_STATE.BASE;
    }
}

// Default Attacks

function default_heavy_attack_state(){
    
}

function default_light_attack_state(){
    animation_start(character.s_l_atk[0],character.s_l_atk[1]);
    
    if(animation_end()){
        state = CHARACTER_STATE.BASE;
    }
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

function default_special_state(){
    
}