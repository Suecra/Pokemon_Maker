extends Node

const Switch = preload("res://Source/Scripts/Battle/Switch.gd")

signal choice_made(sender, half_turn)

var current_pokemon
var pokemon_party
var bag
var field
var battle

func has_pokemon_left():
	return pokemon_party.get_battler_count() > 0

func _do_half_turn():
	pass

func _force_switch_in():
	pass

func _select_targets(move):
	pass

func switch(battler_index: int):
	var new_pokemon = pokemon_party.get_battler(battler_index)
	var switch = Switch.new()
	switch.pokemon = current_pokemon
	switch.trainer = self
	switch.to_pokemon = new_pokemon
	return switch

func move(move_index: int):
	var move = current_pokemon.get_movepool().get_move(move_index)
	move.trainer = self
	return move

func query_delete_move():
	return false

func _ready():
	set_physics_process(false)
	pokemon_party = $PokemonParty
	current_pokemon = pokemon_party.get_pokemon(0)

func _enter_tree():
	battle = get_parent()