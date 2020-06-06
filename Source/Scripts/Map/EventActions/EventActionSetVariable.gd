extends "res://Source/Scripts/Map/EventAction.gd"

class_name EventActionSetVariable

export(String) var var_name 
var value
var var_owner

func _execute():
	var_owner.set(var_name, value)
	return false

func _init(var_owner, var_name: String, value = true):
	self.var_owner = var_owner
	self.var_name = var_name
	self.value = value
