extends "res://Source/Scripts/Battle/BattleAnimation.gd"

var pokemon: Node

func _execute() -> void:
	var sprite = pokemon.get_sprite()
	yield(sprite._faint(), "completed")
