event_inherited();
life = 10;
spd = 250;
sprite_grid_index = 0;
moves_list_index = 0;

character = new character_define(life,spd,0,sprite_grid_index,moves_list_index);
character.define_move_set();

show_message(character);

fill_combo_grid();