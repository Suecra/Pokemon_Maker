extends "res://Source/Scripts/Battle System/Layer 1/Effects/FieldTurnAction.gd"

func init() -> void:
	priority = 8
	set_name("BeginOfTurn")

func do_action() -> void:
	v("begin_of_turn", [])