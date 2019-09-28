extends "res://Source/Scripts/Battle/Trainer.gd"

func _do_half_turn():
	var movepool = current_pokemon.get_movepool()
	var move_index = randi() % movepool.get_child_count()
	emit_signal("choice_made", self, move(move_index))

func _force_switch_in():
	emit_signal("choice_made", self, switch(0))