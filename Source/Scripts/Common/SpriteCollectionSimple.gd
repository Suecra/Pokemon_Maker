extends "res://Source/Scripts/Common/SpriteCollection.gd"

const PokemonSpriteSimple = preload("res://Source/Scripts/Common/PokemonSpriteSimple.gd")

export(Texture) var front
export(Texture) var female_front
export(Texture) var shiny_front
export(Texture) var shiny_female_front

export(Texture) var back
export(Texture) var female_back
export(Texture) var shiny_back
export(Texture) var shiny_female_back

func _get_sprite(id: int) -> Node:
	var sprite = PokemonSpriteSimple.new()
	var a_sprite = Sprite.new()
	a_sprite.name = "Sprite"
	sprite.add_child(a_sprite)
	a_sprite.owner = sprite
	match id:
		Sprites.Front: a_sprite.texture = front
		Sprites.Female_Front: a_sprite.texture = female_front
		Sprites.Shiny_Front: a_sprite.texture = shiny_front
		Sprites.Shiny_Female_Front: a_sprite.texture = shiny_female_front
		Sprites.Back: a_sprite.texture = back
		Sprites.Female_Back: a_sprite.texture = female_back
		Sprites.Shiny_Back: a_sprite.texture = shiny_back
		Sprites.Shiny_Female_Back: a_sprite.texture = shiny_female_back
	sprite.name = "PKMNSprite"
	return sprite
