extends "res://Source/Scripts/Battle/HalfTurn.gd"

var to_pokemon

func _init():
	priority = 6

func _execute():
	print("Sent out " + to_pokemon.nickname + "!")
	trainer.current_pokemon = to_pokemon
	var status_bar = battlefield.get_status_bar(field)
	status_bar.initialize(to_pokemon)
	status_bar.show()