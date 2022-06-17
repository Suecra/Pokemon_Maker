extends "res://Source/Scripts/Battle System/Layer 1/Effects/FieldTurnAction.gd"

func init() -> void:
	priority = -8
	set_name("EndOfTurn")

func do_action() -> void:
	v("end_of_turn", [])
