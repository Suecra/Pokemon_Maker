extends "res://Source/Scripts/Battle/BattleAnimation.gd"

var status: String

func _execute() -> void:
	if hp_bar != null:
		hp_bar.status = status
	yield(get_tree().create_timer(0.0), "timeout")
