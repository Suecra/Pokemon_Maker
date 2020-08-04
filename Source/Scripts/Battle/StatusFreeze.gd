extends "res://Source/Scripts/Battle/PrimaryStatus.gd"

func _can_move(args: Reference) -> void:
	if Utils.trigger(0.2):
		_heal()
	else:
		args.can_move = false
		battle.register_message(pokemon.nickname + " is frozen solid!")

func _heal() -> void:
	battle.register_message(pokemon.nickname + " unfreezed!")
	._heal()

func _ready() -> void:
	status_name = "Freeze"
	register(pokemon, "CAN_MOVE", "_can_move")
	battle.register_message(pokemon.nickname + " was frozen!")
