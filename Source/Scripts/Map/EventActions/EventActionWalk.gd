extends "res://Source/Scripts/Map/EventAction.gd"

class_name EventActionWalk

export(int) var steps = 1
var character: Node

func _execute() -> bool:
	character = event.caller.character
	character.connect("stopped", self, "finish")
	character.walk(steps)
	return true

func _init(steps: int) -> void:
	self.steps = steps
