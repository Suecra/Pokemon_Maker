extends "res://Source/Scripts/Battle/PrimaryStatus.gd"

const Utils = preload("res://Source/Scripts/Utils.gd")

func _can_move():
	if Utils.trigger(0.25):
		battle.register_message(subject_owner.nickname + " is paralysed! It can't move!")
		return false
	return true

func _heal():
	battle.register_message(subject_owner.nickname + " was cured from it's paralysis!")

func _ready():
	status_name = "Paralysis"