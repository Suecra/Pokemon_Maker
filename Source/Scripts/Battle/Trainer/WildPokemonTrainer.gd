extends "res://Source/Scripts/Battle/Trainer.gd"

var usable_moves = []

func _do_half_turn() -> void:
	._do_half_turn()
	usable_moves.clear()
	var movepool = current_pokemon.movepool
	for i in movepool.get_child_count():
		var move = movepool.get_move(i)
		if move._can_use():
			usable_moves.append(i)
	if usable_moves.size() == 0:
		emit_signal("choice_made", self, struggle())
		return
	var move_index = randi() % usable_moves.size()
	emit_signal("choice_made", self, move(usable_moves[move_index]))

func _force_switch_in() -> void:
	._force_switch_in()
	emit_signal("choice_made", self, switch(0))
