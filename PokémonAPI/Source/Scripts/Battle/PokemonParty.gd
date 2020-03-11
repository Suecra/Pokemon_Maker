extends Node

const Pokemon = preload("res://Source/Scripts/Battle/Pokemon.gd")

var trainer

func get_pokemon_count():
	return get_child_count()

func get_pokemon(index: int):
	return get_child(index)

func get_battler_count():
	var count = 0
	for pokemon in get_children():
		if not pokemon.fainted():
			count += 1
	return count

func get_battler(index: int):
	var i = 0
	for pokemon in get_children():
		if not pokemon.fainted():
			if i == index:
				return pokemon
			else:
				i += 1
	return null

func add_pokemon(pokemon: Pokemon):
	add_child(pokemon)
	pokemon.owner = self

func remove_pokemon(pokemon: Pokemon):
	remove_child(pokemon)

func exchange(pokemon1: Pokemon, pokemon2: Pokemon):
	var index = pokemon2.get_index()
	move_child(pokemon2, pokemon1.get_index())
	move_child(pokemon1, index)

func get_lead():
	if get_pokemon_count() > 0:
		return get_children()[0]
	return null

func all_fainted():
	return get_battler_count() == 0

func to_string_array():
	var arr = []
	for pokemon in get_children():
		arr.append(pokemon.nickname)
	return arr

func to_string_array_battler():
	var arr = []
	for i in range(get_battler_count()):
		arr.append(get_battler(i).nickname)
	return arr

func save(path):
	for pokemon in get_children():
		pokemon.prepare_for_save(self)
	var scene = PackedScene.new()
	scene.pack(self)
	ResourceSaver.save(path, scene)

func _enter_tree():
	trainer = get_parent()