/// @description Insert description here
// You can write your code in this editor

//criando a camera
var cam = instance_create_layer(x, y, layer, obj_camera)
cam.alvo = id

// Inherit the parent event
event_inherited();

max_vida = 10
vida = max_vida

max_hsp = 4
max_vsp = 6

mostra_estado = true

combo = 0

dano = noone

ataque = 1

posso = true

ataque_mult = 1

ataque_buff = room_speed

dash_spd = 6