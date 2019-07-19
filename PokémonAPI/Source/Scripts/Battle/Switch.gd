extends "res://Source/Scripts/Battle/HalfTurn.gd"

var to_pokemon

func _init():
	priority = 6

func _execute():
	print("Sent out " + to_pokemon.nickname + "!")
	trainer.current_pokemon = to_pokemon