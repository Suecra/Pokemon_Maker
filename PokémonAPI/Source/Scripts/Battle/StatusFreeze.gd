extends "res://Source/Scripts/Battle/PrimaryStatus.gd"

const Utils = preload("res://Source/Scripts/Utils.gd")

func _can_move(args):
	if Utils.trigger(0.2):
		_heal()
	else:
		args.can_move = false
		battle.register_message(pokemon.nickname + " is frozen solid!")

func _heal():
	battle.register_message(pokemon.nickname + " unfreezed!")
	._heal()

func _ready():
	status_name = "Freeze"
	register(pokemon, "CAN_MOVE", "_can_move")
	battle.register_message(pokemon.nickname + " was frozen!")
