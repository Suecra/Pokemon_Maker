extends "res://Source/Scripts/Battle/BattleAnimation.gd"

export(String, MULTILINE) var message

func _execute() -> void:
	yield(battle.get_node("MessageBox").display(message), "completed")
