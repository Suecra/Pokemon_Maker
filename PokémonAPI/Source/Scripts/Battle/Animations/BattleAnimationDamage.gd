extends "res://Source/Scripts/Battle/BattleAnimation.gd"

var status_bar
var damage

func _execute():
	yield(status_bar.animate_damage(damage), "completed")
