extends "res://Source/Scripts/Battle/HalfTurn.gd"

func _get_priority() -> int:
	return 99

func _execute() -> void:
	trainer.left_battle = true
	battle.register_message("The battle has been resigned!")
