extends "res://Source/Scripts/Battle System/Layer 1/Effects/FieldTurnAction.gd"

const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")

var fighter: Fighter

func _init() -> void:
	priority = 6
	set_name("Switch")

func do_action() -> void:
	v("switch", [fighter])
