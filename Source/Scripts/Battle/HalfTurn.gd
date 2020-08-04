extends Node

export(int) var priority setget ,_get_priority

var trainer: Node
var pokemon: Node
var field: Node
var turn: Node
var battle: Node
var battlefield: Node

func _get_priority() -> int:
	return priority

func get_pokemon_speed() -> int:
	return pokemon.current_speed

func same_priority(half_turn: Node) -> bool:
	return self.priority == half_turn.priority && get_pokemon_speed() == half_turn.get_pokemon_speed()

func _execute() -> void:
	pass
