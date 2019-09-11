extends "res://Source/Scripts/Battle/Status.gd"

const Utils = preload("res://Source/Scripts/Utils.gd")

func _can_move():
	if Utils.trigger(0.25):
		battle.register_message(pokemon.nickname + " is paralysed! It can't move!")
		return false
	return true

func _heal():
	battle.register_message(pokemon.nickname + " was cured from it's paralysis!")

func _ready():
	status_name = "Paralysis"