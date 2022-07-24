/// @description Insert description here
// You can write your code in this editor

//Iniciando variaveis
var right, left, jump, attack
var chao = place_meeting(x, y + 1, obj_block)

right = keyboard_check(ord("D"))
left = keyboard_check(ord("A"))
jump = keyboard_check_pressed(ord("K"))
attack = keyboard_check_pressed(ord("J"))


//Codigo de movimentação
hsp = (right - left) * max_hsp

//aplicando gravidade
if !chao {
	if vsp < max_vsp * 2{
		vsp += GRAVIDADE * massa
	}
}

//iniciando a maquina de estados
switch estado {
	case "parado": {
		sprite_index = spr_player_idle
		
		//condição de troca de estado
		//movendo
		if right || left{
			estado = "movendo"	
		}else if jump || vsp != 0{
			estado = "pulando"
			vsp = (-max_vsp * jump)
			image_index = 0
		}else if attack{
			estado = "ataque"
			hsp = 0
			image_index = 0
		}
		break
	}
	case "movendo": {
		//comportamento do estado de movimento
		sprite_index = spr_player_movendo
		
		//condição de troca de estado
		//parado
		if abs(hsp) < .1{
			estado = "parado"
			hsp = 0
		}else if jump{
			estado = "pulando"
			image_index = 0
			vsp = -max_vsp
		}else if attack{
			estado = "ataque"
			hsp = 0
			image_index = 0
		}
		break
	}
	case "pulando":{
		if vsp > 0 {
			sprite_index = spr_player_caindo
		}else{
			sprite_index = spr_player_pulo
			
			//garantindo que a animação não se repita
			if image_index >= image_number - 1{
				image_index	= image_number - 1
			}
		}
		//condição de troca de estado
		if chao {
			estado = "parado"
			hsp = 0
		}
		break
	}
	case "ataque": {
		hsp = 0
		if combo ==0{
			sprite_index = spr_player_atacando
		}else if combo == 1{
			sprite_index = spr_player_atacando2
		}else if combo == 2{
			sprite_index = spr_player_atacando3
		}
		
		if  attack && combo < 2 && image_index >= image_number - 2{
			combo ++
			image_index = 0
		}
		
		if image_index > image_number - 1{
			estado = "parado"
			hsp = 0
			combo = 0
		}
	}
}