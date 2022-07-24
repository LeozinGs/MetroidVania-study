/// @description Insert description here
// You can write your code in this editor


//Sistema de colisão e movimentação
var _hsp = sign(hsp)
var _vsp = sign(vsp)

//Horizontal
repeat (abs(hsp)){
	if place_meeting(x + _hsp, y, obj_block) {
		hsp = 0
		break
	}
	x += _hsp
}

//Vertical
repeat (abs(vsp)){
	if place_meeting(x, y + _vsp, obj_block){
		vsp = 0
		break
	}
	y += _vsp
}