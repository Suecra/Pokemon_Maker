extends "res://Source/Scripts/Battle/PrimaryStatus.gd"

const Utils = preload("res://Source/Scripts/Utils.gd")

func _can_move():
	if Utils.trigger(0.2):
		_heal()
		return true
	battle.register_message(subject_owner.nickname + " is frozen solid!")
	return false

func _heal():
	battle.register_message(subject_owner.nickname + " unfreezed!")
	._heal()

func _ready():
	status_name = "Freeze"
	battle.register_message(subject_owner.nickname + " was frozen!")
