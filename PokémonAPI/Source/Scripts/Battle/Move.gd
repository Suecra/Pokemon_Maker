extends "res://Source/Scripts/Battle/HalfTurn.gd"

const MoveData = preload("res://Source/Data/Move.gd")

export(PackedScene) var move
export(int) var current_pp setget set_current_pp

var targets = []

func set_current_pp(value: int):
	var data = get_move_data()
	current_pp = min(value, data.pp)
	current_pp = max(current_pp, 0)

func get_move_data():
	if has_node("Move"):
		return $Move
	elif move != null:
		var node = move.instance()
		node.name = "Move"
		add_child(node)
		node.owner = self
		return node
	return null

func can_use():
	return current_pp > 0

func select_targets():
	pass

func _execute():
	current_pp -= 1
	var move = get_move_data()
	if move != null:
		move.user = pokemon
		move.battle = turn.battle
		move.targets.clear()
		move.targets.append(battle.battlefield.get_pokemon_at_position(3, field))
		move._execute()