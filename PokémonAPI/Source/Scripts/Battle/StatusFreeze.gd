extends "res://Source/Scripts/Battle/Status.gd"

const Utils = preload("res://Source/Scripts/Utils.gd")

func _can_move():
	if Utils.trigger(0.2):
		_heal()
		return true
	battle.register_message(pokemon.nickname + " is frozen solid!")
	return false

func _heal():
	battle.register_message(pokemon.nickname + " unfreezed!")

func _ready():
	status_name = "Freeze"
