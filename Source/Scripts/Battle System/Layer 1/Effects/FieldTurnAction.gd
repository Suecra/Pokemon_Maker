extends "res://Source/Scripts/Battle System/Layer 1/Effects/TurnAction.gd"

func _register() -> void:
	._register()
	set_name("FieldTurnAction")

func get_reference_speed() -> BattleFloat:
	return BattleFloat.new(f("get_max_speed", []).value)
