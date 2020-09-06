extends "res://Source/Scripts/Map/EventNode.gd"

class_name EventAction

var event: Node

signal finished

func execute() -> void:
	if _execute():
		yield(self, "finished")
	else:
		yield(get_tree().create_timer(0.0), "timeout")

func _execute() -> bool:
	return false

func finish() -> void:
	_de_init()
	emit_signal("finished")

func _de_init() -> void:
	pass
