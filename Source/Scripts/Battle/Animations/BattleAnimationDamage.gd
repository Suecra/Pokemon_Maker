extends "res://Source/Scripts/Battle/BattleAnimation.gd"

var status_bar: Node
var damage: int

func _execute() -> void:
	yield(status_bar.animate_damage(damage), "completed")
