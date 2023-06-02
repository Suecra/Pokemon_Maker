extends "res://Source/Scripts/Battle System/Layer 1/Effects/FieldTurnAction.gd"

func _init() -> void:
	priority = -8
	cardinality = 1
	set_name("EndOfTurn")

func do_action() -> void:
	v("end_of_turn", [])
