extends "res://Source/Scripts/Battle System/Layer 1/Effects/FieldTurnAction.gd"

var move_name: String
var target_positions: Array

func init() -> void:
	priority = 0
	set_name("Fight")

func do_action() -> void:
	v("execute_move", [move_name, target_positions])

func get_priority() -> BattleInt:
	return i("get_move_priority", [])
