extends Node

const Pokemon = preload("res://Source/Scripts/Battle/Pokemon.gd")

func get_pokemon_count() -> int:
	return get_child_count()

func get_pokemon(index: int) -> Node:
	return get_child(index)

func get_battler_count() -> int:
	var count = 0
	for pokemon in get_children():
		if not pokemon.fainted():
			count += 1
	return count

func get_battler(index: int) -> Node:
	var i = 0
	for pokemon in get_children():
		if not pokemon.fainted():
			if i == index:
				return pokemon
			else:
				i += 1
	return null

func add_pokemon(pokemon: Pokemon) -> void:
	add_child(pokemon)
	pokemon.owner = self

func remove_pokemon(pokemon: Pokemon) -> void:
	remove_child(pokemon)

func exchange(pokemon1: Pokemon, pokemon2: Pokemon) -> void:
	var index = pokemon2.get_index()
	move_child(pokemon2, pokemon1.get_index())
	move_child(pokemon1, index)

func get_lead() -> Node:
	if get_pokemon_count() > 0:
		return get_children()[0]
	return null

func all_fainted() -> bool:
	return get_battler_count() == 0

func to_string_array() -> Array:
	var arr = []
	for pokemon in get_children():
		arr.append(pokemon.nickname)
	return arr

func to_string_array_battler() -> Array:
	var arr = []
	for i in range(get_battler_count()):
		arr.append(get_battler(i).nickname)
	return arr

func full_heal_all() -> void:
	for pokemon in get_children():
		pokemon.full_heal()

func save(path: String) -> void:
	for pokemon in get_children():
		pokemon.prepare_for_save(self)
	var scene = PackedScene.new()
	scene.pack(self)
	ResourceSaver.save(path, scene)
