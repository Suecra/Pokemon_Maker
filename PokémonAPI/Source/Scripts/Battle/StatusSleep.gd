extends "res://Source/Scripts/Battle/PrimaryStatus.gd"

var counter

func _can_move():
	if counter > 0:
		battle.register_message(pokemon.nickname + " is fast asleep!")
		return false
	_heal()
	return true

func _heal():
	battle.register_message(pokemon.nickname + " woke up!")
	._heal()

func _ready():
	status_name = "Sleep"
	register(pokemon, "TURN_STARTS", "_begin_of_turn")
	battle.register_message(pokemon.nickname + " fell asleep!")
	counter = randi() % 3 + 1

func _begin_of_turn():
	counter -= 1