extends "res://Source/Scripts/Battle/Trainer.gd"

func _do_half_turn():
	emit_signal("choice_made", self, move(0))
