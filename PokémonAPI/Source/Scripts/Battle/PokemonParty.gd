extends Node

const Pokemon = preload("res://Source/Scripts/Battle/Pokemon.gd")

var trainer

func get_pokemon_count():
	return get_child_count()

func get_pokemon(index: int):
	return get_child(index)

func add_pokemon(pokemon: Pokemon):
	add_child(pokemon)

func exchange(pokemon1: Pokemon, pokemon2: Pokemon):
	var index = pokemon2.get_index()
	move_child(pokemon2, pokemon1.get_index())
	move_child(pokemon1, index)

func get_lead():
	if get_pokemon_count() > 0:
		return get_children()[0]
	return null

func all_fainted():
	for pokemon in get_children():
		if not pokemon.fainted():
			return false
	return true

func _enter_tree():
	trainer = get_parent()