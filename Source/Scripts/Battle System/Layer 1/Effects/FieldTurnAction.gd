extends "res://Source/Scripts/Battle System/Layer 1/Effects/TurnAction.gd"

func _init() -> void:
	set_name("FighterFunctions")

func get_reference_speed() -> BattleFloat:
	return f("get_max_speed", [true])
