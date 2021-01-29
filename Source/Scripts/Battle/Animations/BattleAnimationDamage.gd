extends "res://Source/Scripts/Battle/BattleAnimation.gd"

var hp_bar: Node
var hp: int

func _execute() -> void:
	hp_bar.hp = hp
	yield(hp_bar, "animation_finished")
