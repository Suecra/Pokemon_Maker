extends "res://Source/Scripts/Battle/Status.gd"

var counter

func _can_move():
	if counter > 0:
		battle.register_message(pokemon.nickname + " is fast asleep!")
		return false
	_heal()
	return true

func _heal():
	battle.register_message(pokemon.nickname + " woke up!")

func _ready():
	status_name = "Sleep"
	battle.register_message(pokemon.nickname + " fell asleep!")
	counter = randi() % 3 + 1

func _begin_of_turn():
	counter -= 1