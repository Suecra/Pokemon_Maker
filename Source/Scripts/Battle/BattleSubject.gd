extends "res://Source/Scripts/Common/Subject.gd"

var battle: Node
var pokemon: Node

func _get_priority() -> int:
	return pokemon.current_speed
