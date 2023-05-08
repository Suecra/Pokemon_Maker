extends "res://Source/Scripts/Battle System/Layer 1/Effects/TurnAction.gd"

func _init() -> void:
	set_name("FieldTurnAction")

func get_reference_speed() -> BattleNumber:
	return BattleNumber.new(f("get_max_speed", [true]))
