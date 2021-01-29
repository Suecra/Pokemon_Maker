extends "res://Source/Scripts/Battle/BattleAnimation.gd"

var hp_bar: Node
var status: String

func _execute() -> void:
	hp_bar.status = status
	yield(get_tree().create_timer(0.0), "timeout")
