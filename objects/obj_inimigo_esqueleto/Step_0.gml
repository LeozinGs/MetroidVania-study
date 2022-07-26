/// @description Insert description here
// You can write your code in this editor

var chao = place_meeting(x, y + 1, obj_block)

if !chao {
	vsp += GRAVIDADE * massa
}

switch estado{
	case "parado":{
		if sprite_index != spr_inimigo_esqueleto_idle{
			image_index = 0
		}
		sprite_index = spr_inimigo_esqueleto_idle
		
		//condição de troca de estado
		if position_meeting(mouse_x, mouse_y, self){
			if mouse_check_button_pressed(mb_right){
				estado = "hit"
			}
		}
		
		break
	}
	case "hit":{
		if sprite_index != spr_inimigo_esqueleto_hit{
			//iniciando o que for preciso para este estado
			image_index = 0
			//vida --
		}
		sprite_index = spr_inimigo_esqueleto_hit
		
		//condição para sair do estado de hit
		if vida > 0{
			if image_index > image_number -1{
				estado = "parado"
			}
		}
		else{
			if image_index >= 3{
				estado = "dead"
			}
		}
		break
	}
	case "dead":{
		if sprite_index != spr_inimigo_esqueleto_dead{
			//iniciando o que for preciso para este estado
			image_index = 0
		}
		sprite_index = spr_inimigo_esqueleto_dead
		
		//morrendo de verdade
		if image_index > image_number - 1{
			image_speed = 0
			image_alpha -= .03
			
			if image_alpha <= 0{
				instance_destroy()
			}
		}
		
		break
	}
}