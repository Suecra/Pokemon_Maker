extends "res://Source/Scripts/Battle/HalfTurn.gd"

const MoveData = preload("res://Source/Data/Move.gd")
const Utils = preload("res://Source/Scripts/Utils.gd")

export(PackedScene) var move
export(int) var current_pp setget set_current_pp

var targets = []

func _get_priority():
	return get_move_data().priority

func set_current_pp(value: int):
	var data = get_move_data()
	current_pp = min(value, data.pp)
	current_pp = max(current_pp, 0)

func get_move_data():
	return Utils.unpack(self, move, "Move")

func can_use():
	return current_pp > 0

func select_targets():
	pass

func _execute():
	current_pp -= 1
	var move = get_move_data()
	if move != null:
		if pokemon.can_move():
			move.user = pokemon
			move.turn = turn
			move.battle = turn.battle
			move.targets.clear()
			move.targets.append(battle.battlefield.get_pokemon_at_position(3, field))
			battle.register_message(pokemon.nickname + " uses " + move.move_name + "!")
			move._execute()