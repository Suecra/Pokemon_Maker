extends "res://Source/Scripts/Battle/PrimaryStatus.gd"

var counter

func _can_move(args: Reference) -> void:
	if counter > 0:
		battle.register_message(pokemon.nickname + " is fast asleep!")
		args.can_move = false
	else:
		_heal()

func _heal() -> void:
	battle.register_message(pokemon.nickname + " woke up!")
	._heal()

func _ready() -> void:
	status_name = "Sleep"
	register(pokemon, "TURN_STARTS", "_begin_of_turn")
	register(pokemon, "CAN_MOVE", "_can_move")
	battle.register_message(pokemon.nickname + " fell asleep!")
	counter = randi() % 3 + 1

func _begin_of_turn() -> void:
	counter -= 1
