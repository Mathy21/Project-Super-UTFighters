
set_inputs();

script_execute(state_array[state]);

side_checker();

inputs_symbols_array = [[inputs[player_num].up,"up"],
                        [inputs[player_num].left,"left"],
                        [inputs[player_num].down,"down"],
                        [inputs[player_num].right,"right"],
                        [inputs[player_num].light_atk,"l_atk"],
                        [inputs[player_num].heavy_atk,"h_atk"],
                        [inputs[player_num].light_kick,"l_kck"],
                        [inputs[player_num].heavy_kick,"h_kck"]];

check_key();


compare_buffer_and_grid();