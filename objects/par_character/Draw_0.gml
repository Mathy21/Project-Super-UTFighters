draw_self();

draw_text(x,y-sprite_height,state);
draw_text(x,y+sprite_height,player_num);

draw_text(x-sprite_width,y+sprite_height/2,hspd);
draw_text(x-sprite_width,y-sprite_height/2,vspd);

draw_text(x,y-sprite_height*2,keyboard_key);
draw_text(x+sprite_width,y-sprite_height*2,input_buffer);

if(mask_index != -1){
    draw_sprite(mask_index,image_index,x,y);
}