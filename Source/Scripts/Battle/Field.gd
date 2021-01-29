extends Node

const SpeedSorter = preload("res://Source/Scripts/Battle/SpeedSorter.gd")

var size: int
var trainers = []
var hp_bar: Node

func get_all_fighting_pokemon() -> Array:
	var list = []
	for trainer in trainers:
		if not trainer.current_pokemon.fainted():
			list.append(trainer.current_pokemon)
	return list

func get_pokemon_at_position(position: int) -> Node:
	if position > size:
		return null
	if trainers.size() >= position:
		return trainers[position].current_pokemon
	return trainers[0].current_pokemon

func begin_of_turn() -> void:
	var pokemon = get_all_fighting_pokemon()
	SpeedSorter.sort(pokemon)
	for p in pokemon:
		p.begin_of_turn()

func end_of_turn() -> void:
	var pokemon = get_all_fighting_pokemon()
	SpeedSorter.sort(pokemon)
	for p in pokemon:
		p.end_of_turn()
