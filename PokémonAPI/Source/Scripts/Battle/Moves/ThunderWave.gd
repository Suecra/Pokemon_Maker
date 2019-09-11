extends "res://Source/Data/StatusMove.gd"

func _hit():
	for t in targets:
		t.paralyse()
		register_status(t)
