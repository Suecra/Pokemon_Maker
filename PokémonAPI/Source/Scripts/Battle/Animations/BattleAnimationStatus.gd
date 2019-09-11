extends "res://Source/Scripts/Battle/BattleAnimation.gd"

var pokemon

func _execute():
	pokemon.status_bar.update_status()
	yield(get_tree().create_timer(0.0), "timeout")