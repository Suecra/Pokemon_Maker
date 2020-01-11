extends "res://Source/Scripts/Battle/PrimaryStatus.gd"

const Utils = preload("res://Source/Scripts/Utils.gd")

func _can_move():
	if Utils.trigger(0.2):
		_heal()
		return true
	battle.register_message(pokemon.nickname + " is frozen solid!")
	return false

func _heal():
	battle.register_message(pokemon.nickname + " unfreezed!")
	._heal()

func _ready():
	status_name = "Freeze"
	battle.register_message(pokemon.nickname + " was frozen!")
