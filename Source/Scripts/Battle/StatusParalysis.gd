extends "res://Source/Scripts/Battle/PrimaryStatus.gd"

func _can_move(args: Reference) -> void:
	if Utils.trigger(0.25):
		args.can_move = false
		battle.register_message(pokemon.nickname + " is paralysed! It can't move!")

func _heal() -> void:
	battle.register_message(pokemon.nickname + " was cured from it's paralysis!")
	._heal()

func _ready() -> void:
	register(pokemon, "CAN_MOVE", "_can_move")
	status_name = "Paralysis"
