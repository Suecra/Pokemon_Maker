extends "res://Source/Scripts/Battle/BattleAnimation.gd"

var pokemon: Node

func _execute() -> void:
	pokemon.status_bar.update_status()
	yield(get_tree().create_timer(0.0), "timeout")
