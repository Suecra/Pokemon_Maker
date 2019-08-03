extends "res://Source/Scripts/Battle/BattleAnimation.gd"

var pokemon

func _execute():
	var sprite = pokemon.get_sprite()
	yield(sprite._out_of_pokeball(), "completed")
