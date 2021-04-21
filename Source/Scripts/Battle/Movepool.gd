extends Node

const BattleMove = preload("res://Source/Scripts/Battle/Move.gd")

var pokemon: Node

func get_move(index: int) -> Move:
	var move = get_child(index)
	move.pokemon = pokemon
	return move

func clear() -> void:
	while get_child_count() > 0:
		remove_child(get_child(0))

func count() -> int:
	return get_child_count()

func has_space() -> bool:
	 return count() < 4

func has_moves_left() -> bool:
	for move in get_children():
		if move._can_use():
			return true
	return false

func swap(index1: int, index2: int) -> void:
	var move = get_child(index1)
	move_child(move, index2)

func add_move(name: String) -> void:
	var move = BattleMove.new()
	move.move_name = name
	move.name = "Move" + str(count() + 1)
	move.current_pp = 99
	add_child(move)
	move.owner = self

func to_string_array() -> Array:
	var moves = []
	for move in get_children():
		moves.append(move.data.get_move_name())
	return moves

func fill_from_last_learnable_moves() -> void:
	while get_child_count() > 0:
		remove_child(get_child(0))
	for move in pokemon.get_last_learnable_moves():
		add_move(move.move)

func prepare_for_save(new_owner: Node):
	owner = new_owner
	for move in get_children():
		if move.has_node("Move"):
			move.remove_child($Move)
		move.owner = new_owner
