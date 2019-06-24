extends Node

signal choice_made(sender, half_turn)

var current_pokemon
var pokemon_party
var bag
var field

func has_pokemon_left():
	return pokemon_party.get_pokemon_count() > 0

func _do_half_turn():
	pass

func _ready():
	pass
