extends Control

const WildPokemonTrainer = preload("res://Source/Scripts/Battle/Trainer/WildPokemonTrainer.gd")
const PlayerTrainer = preload("res://Source/Scripts/Battle/Trainer/PlayerTrainer.gd")
const Utils = preload("res://Source/Scripts/Utils.gd")
const Battle = preload("res://Scenes/BattleBase.tscn")
const PARTY_PATH_1 = "res://Save/pokemon_party_1.tscn"
const PARTY_PATH_2 = "res://Save/pokemon_party_2.tscn"

var pokemon_party1
var pokemon_party2
var player_index: int

signal edit_party

func _ready():
	player_index = 1

func _on_BtnTeam1_button_down():
	emit_signal("edit_party", pokemon_party1)

func _on_BtnTeam2_button_down():
	emit_signal("edit_party", pokemon_party2)

func save_party(pokemon_party):
	if pokemon_party == pokemon_party1:
		pokemon_party.save(PARTY_PATH_1)
	if pokemon_party == pokemon_party2:
		pokemon_party.save(PARTY_PATH_2)

func _on_CbPlayer1_button_down():
	player_index = 1

func _on_CbPlayer2_button_down():
	player_index = 2

func _on_BtnStartBattle_button_down():
	var battle = Battle.instance()
	add_child(battle)
	battle.owner = self
	var trainer1
	var trainer2
	if player_index == 1:
		trainer1 = PlayerTrainer.new()
		battle.add_ally_trainer(trainer1)
		trainer2 = WildPokemonTrainer.new()
		battle.add_opponent_trainer(trainer2)
	if player_index == 2:
		trainer1 = WildPokemonTrainer.new()
		battle.add_opponent_trainer(trainer1)
		trainer2 = PlayerTrainer.new()
		battle.add_ally_trainer(trainer2)
	pokemon_party1.trainer = trainer1
	pokemon_party2.trainer = trainer2
	trainer1.pokemon_party = pokemon_party1
	trainer2.pokemon_party = pokemon_party2
	
	prepare_pokemon()
	$Panel.visible = false
	yield(battle.start(), "completed")
	remove_child(battle)
	$Panel.visible = true

func prepare_pokemon():
	for pokemon in pokemon_party1.get_children():
		pokemon.calculate_stats()
		pokemon.full_heal()
	for pokemon in pokemon_party2.get_children():
		pokemon.calculate_stats()
		pokemon.full_heal()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch:
		if event.pressed:
			Input.action_press("ui_accept")
		else:
			Input.action_release("ui_accept")
