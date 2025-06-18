global.character_database = ds_grid_create(2,4);
global.move_set_list = ds_list_create();

function combo(_combo_name,_combo_inputs) constructor{
    combo_name = _combo_name;
    combo_inputs = _combo_inputs;
}
// Define characters move set array
#region move set
global.move_set_list[| 0] = [new combo("Kill Tomas",["left","down","right","l_atk"]),
                             new combo("Kill all...",["down","right","h_atk"]),
                             new combo("Carlinhos LaserBean",["left","right","down","right","h_atk"])];
#endregion