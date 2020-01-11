extends "res://Source/Scripts/Common/Subject.gd"

var battle
var pokemon

func _get_priority():
	return pokemon.current_speed