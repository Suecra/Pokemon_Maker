extends Node

export(int) var priority

var trainer
var pokemon
var field
var turn
var battle

func get_pokemon_speed():
	return pokemon.speed

func same_priority(half_turn):
	return priority == half_turn.priority && get_pokemon_speed() == half_turn.get_pokemon_speed()

func _execute():
	pass

func _ready():
	pass
