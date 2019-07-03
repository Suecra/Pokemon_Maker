extends Node

var trainers = []
var battle

func get_pokemon_at_position(position: int):
	return trainers[0].current_pokemon

func _ready():
	pass

func _enter_tree():
	battle = get_parent()
