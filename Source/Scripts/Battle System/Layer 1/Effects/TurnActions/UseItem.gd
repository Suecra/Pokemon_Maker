extends "res://Source/Scripts/Battle System/Layer 1/Effects/FieldTurnAction.gd"

var item_name: String

func _init() -> void:
	priority = 6
	set_name("UseItem")

func do_action() -> void:
	v("use_item", [item_name, owner])
