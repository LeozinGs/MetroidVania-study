/// @description Insert description here
// You can write your code in this editor

var outro = instance_place(x, y, obj_entity)

//se estou encostando em alguma entidade
if outro {
	// se nao estou encostando no obj de herança
	if outro.id != pai{
		if outro.vida > 0{
			outro.estado = "hit"
			outro.image_index = 0
			outro.vida -= dano
			instance_destroy()
		}
	}
}

