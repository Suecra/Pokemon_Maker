extends "res://Source/Scripts/Battle System/Layer 1/Effects/FieldTurnAction.gd"

var move_name: String
var target_index: int

func _init() -> void:
	priority = 0
	set_name("Fight")

func do_action() -> void:
	v("execute_move", [move_name, target_index])

func get_priority() -> BattleNumber:
	return BattleNumber.new(i("get_move_priority", []))
