extends Node

const MoveData = preload("res://Source/Data/Move.gd")

export(PackedScene) var move
export(int) var current_pp setget set_current_pp

func set_current_pp(value: int):
	var data = get_move_data()
	current_pp = min(value, data.pp)

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