extends "res://Source/Scripts/Battle/HalfTurn.gd"

const Utils = preload("res://Source/Scripts/Utils.gd")

export(PackedScene) var move
export(int) var current_pp = 0 setget set_current_pp

var target_index: int
var targets = []

func _get_priority():
	var data = get_move_data()
	if data != null:
		return data.priority

func set_current_pp(value: int):
	var data = get_move_data()
	current_pp = min(value, data.pp)
	current_pp = max(current_pp, 0)

func get_move_data():
	return Utils.unpack(self, move, "Move")

func can_use():
	return current_pp > 0

func _execute():
	current_pp -= 1
	var move = get_move_data()
	if move != null:
		if pokemon.can_move():
			var target_positions = move.get_target_positions(pokemon.position, target_index)
			move.user = pokemon
			move.turn = turn
			move.battle = turn.battle
			move.targets = battle.battlefield.get_targets(target_positions, field)
			battle.register_message(pokemon.nickname + " uses " + move.move_name + "!")
			move._execute()