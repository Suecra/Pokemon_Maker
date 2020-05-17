extends Node

class_name EventAction

var event

signal finished

func execute():
	if _execute():
		yield(self, "finished")
	else:
		yield(get_tree().create_timer(0.0), "timeout")

func _execute():
	return false

func finish():
	emit_signal("finished")
