/// @description Insert description here
// You can write your code in this editor

//olhando para o lado certo
if (hsp != 0) {
	xscale = sign(hsp)
}
image_xscale = xscale

//mostrando estado quando o usuario mandar
if position_meeting(mouse_x, mouse_y, id){
	if mouse_check_button_released(mb_left){
		mostra_estado = !mostra_estado
	}
}
image_speed = (img_spd  / room_speed)
