extends "res://Source/Scripts/Battle/HalfTurn.gd"

export(PackedScene) var move
export(int) var current_pp = 0 setget set_current_pp

var target_index: int
var targets = []

func _get_priority() -> int:
	var data = get_move_data()
	if data != null:
		return data.priority
	return ._get_priority()

func set_current_pp(value: int) -> void:
	var data = get_move_data()
	current_pp = min(value, data.pp)
	current_pp = max(current_pp, 0)

func get_move_data() -> Node:
	return Utils.unpack(self, move, "Move")

func _can_use() -> bool:
	return current_pp > 0

func restore_pp() -> void:
	var data = get_move_data()
	if data != null:
		current_pp = data.pp

func _execute() -> void:
	current_pp -= 1
	var move = get_move_data()
	if move != null:
		var target_positions = move.get_target_positions(pokemon.position, target_index)
		move.targets = battle.battlefield.get_targets(target_positions, field)
		move.turn = turn
		move.battle = turn.battle
		pokemon.do_move(move)
