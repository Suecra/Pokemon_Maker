extends "res://Source/Scripts/Battle/SecondaryStatus.gd"

func _init() -> void:
	status_name = "Flinch"

func _ready() -> void:
	register(pokemon, "TURN_ENDS", "_heal_silent")
	register(pokemon, "CAN_MOVE", "can_move")

func can_move(args: Reference) -> void:
	if args.can_move:
		args.can_move = false
		battle.register_message(pokemon.nickname + " flinched and couldn't move!")
