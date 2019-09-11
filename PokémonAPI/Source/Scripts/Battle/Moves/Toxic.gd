extends "res://Source/Data/StatusMove.gd"

func _hit():
	for t in targets:
		t.badly_poison()
		register_status(t)
