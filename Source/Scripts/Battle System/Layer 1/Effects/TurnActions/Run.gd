extends "res://Source/Scripts/Battle System/Layer 1/Effects/FieldTurnAction.gd"

func _init() -> void:
	priority = 6
	set_name("Run")

func do_action() -> void:
	v("try_escape", [])
