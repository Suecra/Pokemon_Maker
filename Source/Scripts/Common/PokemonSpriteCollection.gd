extends Node

enum Sprites {Front, Female_Front, Shiny_Front, Shiny_Female_Front, Back, Female_Back, Shiny_Back, Shiny_Female_Back}

export(PackedScene) var front_sprite
export(PackedScene) var female_front_sprite
export(PackedScene) var shiny_front_sprite
export(PackedScene) var shiny_female_front_sprite

export(PackedScene) var back_sprite
export(PackedScene) var female_back_sprite
export(PackedScene) var shiny_back_sprite
export(PackedScene) var shiny_female_back_sprite

func get_sprite(id: int) -> Node:
	var sprite
	match id:
		Sprites.Front: sprite = front_sprite.instance()
		Sprites.Female_Front: sprite = female_front_sprite.instance()
		Sprites.Shiny_Front: sprite = shiny_front_sprite.instance()
		Sprites.Shiny_Female_Front: sprite = shiny_female_front_sprite.instance()
		Sprites.Back: sprite = back_sprite.instance()
		Sprites.Female_Back: sprite = female_back_sprite.instance()
		Sprites.Shiny_Back: sprite = shiny_back_sprite.instance()
		Sprites.Shiny_Female_Back: sprite = shiny_female_back_sprite.instance()
	sprite.name = "Sprite"
	return sprite
