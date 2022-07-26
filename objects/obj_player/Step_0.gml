/// @description Insert description here
// You can write your code in this editor

//Iniciando variaveis
var right, left, jump, attack, dash

var chao = place_meeting(x, y + 1, obj_block)

right = keyboard_check(ord("D"))
left = keyboard_check(ord("A"))
jump = keyboard_check_pressed(ord("K"))
attack = keyboard_check_pressed(ord("J"))
dash = keyboard_check_pressed(ord("L"))

if ataque_buff > 0{
	ataque_buff -= 1
}


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
	#region parado
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
		}else if dash{
			estado = "dash"
			image_index = 0
		}
		break
	}
	#endregion
	
	#region movendo
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
		}else if dash{
			estado = "dash"
			image_index = 0
		}
		break
	}
	#endregion
	
	#region pulando
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
	#endregion
	
	#region ataque
	case "ataque": {
		hsp = 0
		if combo ==0{
			sprite_index = spr_player_atacando
		}else if combo == 1{
			sprite_index = spr_player_atacando2
		}else if combo == 2{
			sprite_index = spr_player_atacando3
		}
		
		//criando o objeto de dano
		if image_index >= 2 && dano == noone && posso{
			dano = instance_create_layer(x + sprite_width / 2, y - sprite_height / 2, layer, obj_dano)
			dano.dano = ataque * ataque_mult
			dano.pai = id
			posso = false	
		}
		
		//configurando com o buff
		if attack && combo < 2{
			ataque_buff = room_speed
		}
		
		if ataque_buff && combo < 2 && image_index >= image_number - 1{
			combo ++
			image_index = 0
			posso = true
			ataque_mult += .5
			
			if dano{
				instance_destroy(dano, false)
				dano = noone
			}
			
			//zerar o buff
			ataque_buff = 0
		}
		
		if image_index > image_number - 1{
			estado = "parado"
			hsp = 0
			combo = 0
			posso = true
			ataque_mult = 1
			
			if dano{
				instance_destroy(dano, false)
				dano = noone
			}
		}
		if dash{
			estado = "dash"
			image_index = 0
			combo = 0
			if dano{
				instance_destroy(dano, false)
				dano = noone
			}
		}
		break
	}
	#endregion
	
	#region dash
	case "dash":{
		sprite_index = spr_player_dash
		
		//velocidade
		hsp = image_xscale * dash_spd
		
		//saindo do estado
		if image_index >= image_number - 1{
			estado = "parado"
			image_index = 0
		}
		
		break
	}
	#endregion
}
if keyboard_check_pressed(vk_enter){
	room_restart()
}