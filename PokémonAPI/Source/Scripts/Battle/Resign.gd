extends "res://Source/Scripts/Battle/HalfTurn.gd"

func _get_priority():
	return 99

func _execute():
	trainer.resigned = true
	battle.register_message("The battle has been resigned!")