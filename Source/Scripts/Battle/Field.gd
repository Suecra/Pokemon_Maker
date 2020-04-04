extends Node

const SpeedSorter = preload("res://Source/Scripts/Battle/SpeedSorter.gd")

var size: int
var trainers = []
var battle

func get_all_fighting_pokemon():
	var list = []
	for t in trainers:
		if not t.current_pokemon.fainted():
			list.append(t.current_pokemon)
	return list

func get_pokemon_at_position(position: int):
	if position > size:
		return null
	if trainers.size() >= position:
		return trainers[position].current_pokemon
	return trainers[0].current_pokemon

func begin_of_turn():
	var pokemon = get_all_fighting_pokemon()
	SpeedSorter.sort(pokemon)
	for p in pokemon:
		p.begin_of_turn()

func end_of_turn():
	var pokemon = get_all_fighting_pokemon()
	SpeedSorter.sort(pokemon)
	for p in pokemon:
		p.end_of_turn()

func _enter_tree():
	battle = get_parent()
