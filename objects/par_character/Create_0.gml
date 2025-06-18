// Main

char_id = 0;

// Movement
hspd = 0;
vspd = 0;
spd = 250;
player_num = 0;
jump_power = -600;
can_jump = true;

///@method character_define(life,speed,jump_power[default: -600],sprite_grid_index,moves_grid_index)
character_define = function(_life,_spd,_jump_power,_sprite_grid_index,_moves_list_index) constructor {
    life = _life;
    spd = _spd;
    moves_list_index = _moves_list_index;
    combo_array = 0;
    if(_jump_power == 0){
        jump_power = -600;
    }
        else{
            jump_power = _jump_power;
        }
    
    define_move_set = function(){
        combo_array = global.move_set_list[| moves_list_index];
    }
}

character = 0;

// Main combat variables
input_buffer = [];
input_cooldown_v = 60;
input_cooldown = input_cooldown_v;

// Inputs
player_num = 0;
// Player 1 Inputs
inputs_p1 = {
    up: ord("W"),
    left: ord("A"),
    down: ord("S"),
    right: ord("D"),
    // Default Combat
    light_atk: ord("I"),
    heavy_atk: ord("O"),
    light_kick: ord("K"),
    heavy_kick: ord("L")
}
// Player 2 Inputs
inputs_p2 = {
    up: ord("W"),
    left: ord("A"),
    down: ord("S"),
    right: ord("D"),
    // Default Combat
    light_atk: ord("I"),
    heavy_atk: ord("O"),
    light_kick: ord("K"),
    heavy_kick: ord("L")
}
// Inputs array by player number(Player 1 = 0 and Player 2 = 1)
inputs = [inputs_p1,inputs_p2];
up = 0;
left = 0;
down = 0;
right = 0;
// Default Combat
light_atk = 0;
heavy_atk = 0;
light_kick = 0;
heavy_kick = 0;
// Conditionals
is_moving = 0;
combo_grid_w = 3;
combo_grid = ds_grid_create(combo_grid_w,1);

///@method fill_grid(grid index, grid width, grid height, array);
fill_combo_grid = function(){
    var _grid_h = array_length(character.combo_array);
    if(array_length(character.combo_array) > 0){
       ds_grid_resize(combo_grid,combo_grid_w,_grid_h); 
       for(var i=0; i<ds_grid_height(combo_grid); i++){
        var _ca = character.combo_array[i];
        combo_grid[# 0,i] = _ca.combo_name;
        combo_grid[# 1,i] = _ca.combo_inputs;
        combo_grid[# 2,i] = array_length(_ca.combo_inputs);
      }
    }
}

inputs_symbols_array = [];

// State Machine
enum CHARACTER_STATE{
    // ** All this states are setted by default\
    // For new attacks or movements, just create it bellow
    BASE,
    IDLE,
    MOVING_FORWARD,
    MOVING_BACKWARD,
    CROUCHED,
    ON_AIR,
    // ATTACK
    LIGHT_ATTACK,
    HEAVY_ATTACK,
    LIGHT_KICK,
    HEAVY_KICK,
    CROUCHED_ATTACK,
    CROUCHED_KICK,
    AIR_ATTACK,
    AIR_KICK
}

state = CHARACTER_STATE.BASE;
state_array[CHARACTER_STATE.BASE] = default_base_state;
state_array[CHARACTER_STATE.IDLE] = default_idle_state;
state_array[CHARACTER_STATE.MOVING_FORWARD] = default_moving_forward_state;
state_array[CHARACTER_STATE.MOVING_BACKWARD] = default_moving_backward_state;
state_array[CHARACTER_STATE.CROUCHED] = default_crouched_state;
state_array[CHARACTER_STATE.ON_AIR] = default_on_air_state;
state_array[CHARACTER_STATE.LIGHT_ATTACK] = default_light_attack_state;
state_array[CHARACTER_STATE.HEAVY_ATTACK] = default_heavy_attack_state;
state_array[CHARACTER_STATE.LIGHT_KICK] = default_light_kick_state;
state_array[CHARACTER_STATE.HEAVY_KICK] = default_heavy_kick_state;
state_array[CHARACTER_STATE.CROUCHED_ATTACK] = default_crouched_attack_state;
state_array[CHARACTER_STATE.CROUCHED_KICK] = default_crouched_kick_state;
state_array[CHARACTER_STATE.AIR_ATTACK] = default_air_attack_state;
state_array[CHARACTER_STATE.AIR_KICK] = default_air_kick_state;

// Set Inputs Functions
set_inputs = function(){
    up = keyboard_check(inputs[player_num].up);
    left = keyboard_check(inputs[player_num].left);
    down = keyboard_check(inputs[player_num].down);
    right = keyboard_check(inputs[player_num].right);
    // Default Combat
    light_atk = keyboard_check_pressed(inputs[player_num].light_atk);
    heavy_atk = keyboard_check_pressed(inputs[player_num].heavy_atk);
    light_kick = keyboard_check_pressed(inputs[player_num].light_kick);
    heavy_kick = keyboard_check_pressed(inputs[player_num].heavy_kick);
    
    // Conditionals
    is_moving = left || right ? true : false;
}

// Side Checker
side_checker = function(){
    if(x <= room_width/2){
        player_num = 0
    }
    else{
        player_num = 1;
    }
}

// Basic Collision
default_collision = function(){
    repeat(abs(vspd)){
		var _ground_col = place_meeting(x,y+sign(vspd),par_collision);
		if(_ground_col){
			vspd = 0;
			break;
		}
		else{
			y += sign(vspd)*delta_time/1000000;
		}
	}
    repeat(abs(hspd)){
		var _ground_col = place_meeting(x+sign(hspd),y,par_collision);
		if(_ground_col){
			hspd = 0;
			break;
		}
		else{
			x += sign(hspd)*delta_time/1000000;
		}
	}
}

// Check witch kee is being pressed
check_key = function(){
    if(keyboard_key != vk_nokey){
        for(var i=0; i<array_length(inputs_symbols_array); i++){
            if(keyboard_key == inputs_symbols_array[i][0] && keyboard_check_pressed(keyboard_key)){
                array_push(input_buffer,inputs_symbols_array[i][1]);
            }
        }
    }
}

///@method clean_array(array_index);
clean_array = function(_array){
  while(array_length(_array) > 0){
    array_pop(_array);
  }
}

compare_buffer_and_grid = function(){
    if(input_cooldown > 0 && array_length(input_buffer) > 0){
        input_cooldown -= delta_time/1000000 * 60;
    }
        else if(input_cooldown <= 0){
            for(var i=0; i<ds_grid_height(combo_grid); i++){
                var _array_size = array_length(input_buffer);
                if(_array_size > 0 && combo_grid[# 2,i] == _array_size){
                    for(var j=0; j<combo_grid[# 2,i]; j++){
                        if(combo_grid[# 1,i][j] != input_buffer[j]){
                            show_debug_message("Undefined");
                            continue;
                        }
                            else if(j == array_length(combo_grid[# 1,i])-1 && combo_grid[# 1,i][j] == input_buffer[j]){
                                show_debug_message("Finded");
                                clean_array(input_buffer);
                                input_cooldown = input_cooldown_v;
                                break;
                            }
                    }
                    
                }
            }
            clean_array(input_buffer);
            input_cooldown = input_cooldown_v;
        }
}

