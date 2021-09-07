extends Node

class_name SpriteCollection

enum Sprites {Front, Female_Front, Shiny_Front, Shiny_Female_Front, Back, Female_Back, Shiny_Back, Shiny_Female_Back}

func _get_sprite(id: int) -> Node:
	return PokemonSprite.new()

func get_pokemon_sprite(field: Node, pokemon: Node) -> Node:
	if field == pokemon.battle.ally_field:
		return get_back_sprite(pokemon)
	return get_front_sprite(pokemon)

func get_front_sprite(pokemon: Node) -> Node:
	if pokemon.shiny:
		return get_shiny_front_sprite(pokemon)
	return get_normal_front_sprite(pokemon)

func get_back_sprite(pokemon: Node) -> Node:
	if pokemon.shiny:
		return get_shiny_back_sprite(pokemon)
	return get_normal_back_sprite(pokemon)

func get_normal_front_sprite(pokemon: Node) -> Node:
	if pokemon.gender == Consts.Gender.Male:
		return _get_sprite(Sprites.Front)
	return _get_sprite(Sprites.Female_Front)

func get_shiny_front_sprite(pokemon: Node) -> Node:
	if pokemon.gender == Consts.Gender.Male:
		return _get_sprite(Sprites.Shiny_Front)
	return _get_sprite(Sprites.Shiny_Female_Front)

func get_normal_back_sprite(pokemon: Node) -> Node:
	if pokemon.gender == Consts.Gender.Male:
		return _get_sprite(Sprites.Back)
	return _get_sprite(Sprites.Female_Back)

func get_shiny_back_sprite(pokemon: Node) -> Node:
	if pokemon.gender == Consts.Gender.Male:
		return _get_sprite(Sprites.Shiny_Back)
	return _get_sprite(Sprites.Shiny_Female_Back)
