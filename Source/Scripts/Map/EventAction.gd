extends Node

class_name EventAction

var event

signal finished

func execute():
	_execute()
	yield(self, "finished")

func _execute():
	pass

func finish():
	emit_signal("finished")
