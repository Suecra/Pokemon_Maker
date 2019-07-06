extends Node

const Switch = preload("res://Source/Scripts/Battle/Switch.gd")

signal choice_made(sender, half_turn)

var current_pokemon
var pokemon_party
var bag
var field
var battle

func has_pokemon_left():
	return pokemon_party.get_pokemon_count() > 0

func _do_half_turn():
	pass

func _select_targets(move):
	pass

func switch(pokemon_index: int):
	var new_pokemon = pokemon_party.get_pokemon(pokemon_index)
	var switch = Switch.new()
	switch.from_pokemon = current_pokemon
	switch.to_pokemon = new_pokemon
	current_pokemon = new_pokemon

func move(move_index: int):
	return current_pokemon.get_movepool().get_child(0)

func query_delete_move():
	return false

func _ready():
	pokemon_party = $PokemonParty
	current_pokemon = pokemon_party.get_pokemon(0)

func _enter_tree():
	battle = get_parent()