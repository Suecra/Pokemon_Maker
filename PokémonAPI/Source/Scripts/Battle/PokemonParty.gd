extends Node

const Pokemon = preload("res://Source/Scripts/Battle/Pokemon.gd")

func get_pokemon_count():
	return get_child_count()

func add_pokemon(pokemon: Pokemon):
	add_child(pokemon)

func exchange(pokemon1: Pokemon, pokemon2: Pokemon):
	var index = pokemon2.get_index()
	move_child(pokemon2, pokemon1.get_index())
	move_child(pokemon1, index)