extends Node

export(String) var move_name
export(String) var pp

var move_data: Move

func load_move_data() -> void:
	if move_data == null:
		move_data = Move.new(move_name)
		move_data.name = "MoveData"
		add_child(move_data)
		move_data.owner = self
