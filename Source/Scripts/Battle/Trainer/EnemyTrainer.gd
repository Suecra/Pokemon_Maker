extends "res://Source/Scripts/Battle/Trainer.gd"

func _do_half_turn() -> void:
	emit_signal("choice_made", self, move(0))

func _force_switch_in() -> void:
	emit_signal("choice_made", self, switch(0))
