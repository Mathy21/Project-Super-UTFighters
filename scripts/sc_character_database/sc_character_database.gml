global.sprite_set_list = ds_list_create();
global.move_set_list = ds_list_create();

function combo(_combo_name,_combo_inputs) constructor{
    combo_name = _combo_name;
    combo_inputs = _combo_inputs;
}

///@method sprite_set(idle,forward,backward,crouched,light_atk,h_atk,crouch_atk,crouch_kick,light_kick,heavy_kick,air_atk,air_kick)
function sprite_set(_id,_f,_b,_c,_l_at,_h_at,_c_at,_c_k,_l_k,_h_k,_a_at,_a_k) constructor {
    idle = _id;
    forward = _f;
    backward = _b;
    crouched = _c;
    light_atk = _l_at;
    heavy_atk = _h_at;
    crouched_atk = _c_at;
    crouched_kick = _c_k;
    light_kick = _l_k;
    heavy_kick = _h_k;
    air_atk = _a_at;
    air_kick = _a_k;
}
// Define characters move set array
#region move set
global.move_set_list[| 0] = [new combo("Kill Tomas",["left","down","right","l_atk"]),
                             new combo("Kill all",["down","right","h_atk"]),
                             new combo("Carlinhos Gays",["left","right","down","right","h_atk"])];
#endregion

#region sprite set 
global.sprite_set_list[| 0] = new sprite_set(spr_idle_placeholderman,spr_move_forward_placeholderman,
spr_move_backward_placeholderman,spr_crouched_placeholderman,[spr_l_atk_placeholderman,spr_hb_l_atk_placeholderman],
[spr_l_atk_placeholderman,spr_hb_l_atk_placeholderman],[spr_l_atk_placeholderman,spr_hb_l_atk_placeholderman],
[spr_l_atk_placeholderman,spr_hb_l_atk_placeholderman],[spr_l_atk_placeholderman,spr_hb_l_atk_placeholderman],
[spr_l_atk_placeholderman,spr_hb_l_atk_placeholderman],[spr_l_atk_placeholderman,spr_hb_l_atk_placeholderman],
[spr_l_atk_placeholderman,spr_hb_l_atk_placeholderman]);
#endregion