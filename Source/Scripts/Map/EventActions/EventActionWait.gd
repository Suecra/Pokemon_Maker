extends "res://Source/Scripts/Map/EventAction.gd"

class_name EventActionWait

export(int) var milliseconds = 1000

func _execute():
	get_tree().create_timer(float(milliseconds) / 1000).connect("timeout", self, "finish")
	return true

func _init(milliseconds: int):
	self.milliseconds = milliseconds
