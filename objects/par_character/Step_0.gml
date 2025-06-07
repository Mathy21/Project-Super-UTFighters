vspd += GRAV*(delta_time/1000000*10);
var _ground_col = place_meeting(x,y+sign(vspd),par_collision);
if(up && _ground_col && can_jump){
    vspd = jump_power;
}


