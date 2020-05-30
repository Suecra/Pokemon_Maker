extends Node

const Switch = preload("res://Source/Scripts/Battle/Switch.gd")
const Utils = preload("res://Source/Scripts/Utils.gd")
const Move = preload("res://Source/Scripts/Battle/Move.gd")

signal choice_made(sender, half_turn)

var current_pokemon
var pokemon_party
var bag
var field
var battle
var resigned: bool

func has_pokemon_left():
	return pokemon_party.get_battler_count() > 0

func _do_half_turn():
	pass

func _force_switch_in():
	pass

func _select_target():
	return 0

func _get_lead():
	return pokemon_party.get_lead()

func switch(battler_index: int):
	var new_pokemon = pokemon_party.get_battler(battler_index)
	var switch = Switch.new()
	switch.pokemon = current_pokemon
	switch.trainer = self
	switch.to_pokemon = new_pokemon
	switch.turn = battle.current_turn
	return switch

func move(move_index: int):
	if move_index == -1:
		return struggle()
	var move = current_pokemon.get_movepool().get_move(move_index)
	move.trainer = self
	move.target_index = _select_target()
	return move

func struggle():
	var move = Move.new()
	move.move = load("res://Source/Data/Move/struggle.tscn")
	move.trainer = self
	move.pokemon = current_pokemon
	move.target_index = _select_target()
	return move

func custom_move(name: String, target: String):
	var movepool = current_pokemon.get_movepool()
	var moves = movepool.to_string_array()
	var index = moves.find(name)
	if index != -1:
		var move = movepool.get_move(index)
		move.trainer = self
		emit_signal("choice_made", self, move)

func custom_switch(name: String):
	var battlers = pokemon_party.to_string_array_battler()
	var index = battlers.find(name)
	if index != -1:
		var switch = switch(index)
		emit_signal("choice_made", self, switch)

func custom_item(name: String):
	pass

func query_delete_move():
	return false

func _ready():
	set_physics_process(false)
	if has_node("PokemonParty"):
		pokemon_party = $PokemonParty

func init_battle():
	resigned = false
	for i in pokemon_party.get_pokemon_count():
		pokemon_party.get_pokemon(i).init_battle()
		
