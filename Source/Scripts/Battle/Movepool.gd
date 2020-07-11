extends Node

const Move = preload("res://Source/Scripts/Battle/Move.gd")

var pokemon

func get_move(index: int):
	var move = get_child(index)
	move.pokemon = pokemon
	return move

func has_space():
	return get_child_count() < 4

func has_moves_left():
	for move in get_children():
		if move._can_use():
			return true
	return false

func swap(index1: int, index2: int):
	var move = get_child(index1)
	move_child(move, index2)

func add_move(move):
	var move_node = Move.new()
	move_node.name = "Move" + str(get_child_count() + 1)
	move_node.move = move
	move_node.current_pp = 99
	add_child(move_node)
	move_node.owner = self

func to_string_array():
	var moves = []
	for move in get_children():
		moves.append(move.get_move_data().move_name)
	return moves

func fill_from_last_learnable_moves():
	while get_child_count() > 0:
		remove_child(get_child(0))
	for m in pokemon.get_last_learnable_moves():
		add_move(m.move)

func prepare_for_save(new_owner):
	owner = new_owner
	for move in get_children():
		if move.has_node("Move"):
			move.remove_child($Move)
		move.owner = new_owner
