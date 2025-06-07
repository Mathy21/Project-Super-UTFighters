draw_text(view_wport[0]/2,view_yport[0]+10,input_cooldown);


for(var i=0; i<ds_grid_height(combo_grid); i++){
    for(var j=0; j<ds_grid_width(combo_grid); j++){
        draw_text(view_xport[0]+120*j,view_yport[0]+20*i,combo_grid[# i,j]);
    }
}