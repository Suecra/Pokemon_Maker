extends "res://Source/Scripts/Map/EventAction.gd"

class_name EventActionCondition

export(String) var var_name 
var value
var var_owner

func execute():
	if var_owner.get(var_name) == value:
		yield(execute_event_actions(), "completed")
	else:
		yield(get_tree().create_timer(0.0), "timeout")

func _init(var_owner, var_name: String, value = true):
	self.var_owner = var_owner
	self.var_name = var_name
	self.value = value
