extends "res://Source/Scripts/Battle System/Layer 1/Effects/FieldTurnAction.gd"

func init() -> void:
	priority = 6
	set_name("Run")

func execute() -> void:
	v("tr_escape", [])
