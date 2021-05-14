extends Node

const Switch = preload("res://Source/Scripts/Battle/Switch.gd")
const Move = preload("res://Source/Scripts/Battle/Move.gd")

signal choice_made(sender, half_turn)

var current_pokemon: Node
var field: Node
var battle: Node
var left_battle: bool
var switch_forced: bool

onready var pokemon_party := $PokemonParty

func has_pokemon_left() -> bool:
	return pokemon_party.get_fighter_count() > 0

func _do_half_turn() -> void:
	switch_forced = false
	pass

func _force_switch_in() -> void:
	switch_forced = true
	pass

func _select_target() -> int:
	return 0

func _get_lead() -> Node:
	return pokemon_party.get_lead()

func switch(fighter_index: int) -> Switch:
	var new_pokemon = pokemon_party.get_switch_target(fighter_index, current_pokemon)
	var switch = Switch.new()
	switch.forced = switch_forced
	switch.pokemon = current_pokemon
	switch.trainer = self
	switch.to_pokemon = new_pokemon
	switch.turn = battle.current_turn
	return switch

func _get_switch_in_message() -> String:
	return ""

func _get_switch_out_message() -> String:
	return ""

func move(move_index: int) -> Move:
	if move_index == -1:
		return struggle()
	var move = current_pokemon.movepool.get_move(move_index)
	move.trainer = self
	move.target_index = _select_target()
	return move

func struggle() -> Move:
	var move = Move.new()
	move.move_name = "struggle"
	move.trainer = self
	move.pokemon = current_pokemon
	move.target_index = _select_target()
	return move

func custom_move(name: String, target: String) -> void:
	var movepool = current_pokemon.movepool
	var moves = movepool.to_string_array()
	var index = moves.find(name)
	if index != -1:
		var move = movepool.get_move(index)
		move.trainer = self
		emit_signal("choice_made", self, move)

func custom_switch(name: String) -> void:
	var battlers = pokemon_party.to_string_array_battler()
	var index = battlers.find(name)
	if index != -1:
		var switch = switch(index)
		emit_signal("choice_made", self, switch)

func custom_item(name: String) -> void:
	pass

func query_delete_move() -> bool:
	return false

func _ready() -> void:
	set_physics_process(false)
	pokemon_party.full_heal_all()

func _init_battle() -> void:
	left_battle = false
	switch_forced = false
	current_pokemon = null
	for i in pokemon_party.get_pokemon_count():
		var pokemon = pokemon_party.get_pokemon(i)
		pokemon.battle = battle
		pokemon.field = field
		pokemon.init_battle()
		
