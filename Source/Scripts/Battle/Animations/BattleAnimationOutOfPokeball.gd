extends "res://Source/Scripts/Battle/BattleAnimation.gd"

var pokemon: Node

func _execute() -> void:
	var sprite = pokemon.get_sprite()
	yield(sprite._out_of_pokeball(), "completed")
	hp_bar._show()
