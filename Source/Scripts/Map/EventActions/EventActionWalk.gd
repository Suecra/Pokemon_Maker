extends "res://Source/Scripts/Map/EventAction.gd"

class_name EventActionWalk

export(int) var steps = 1
var character

func _execute():
	character = event.caller.character
	character.connect("stopped", self, "finish")
	character.walk(steps)
	return true

func _init(steps: int):
	self.steps = steps
