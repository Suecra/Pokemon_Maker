extends Control

const WildPokemonTrainer = preload("res://Source/Scripts/Battle/Trainer/WildPokemonTrainer.gd")
const PlayerTrainer = preload("res://Source/Scripts/Battle/Trainer/PlayerTrainer.gd")

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

func _on_CbPlayer1_button_down():
	player_index = 1

func _on_CbPlayer2_button_down():
	player_index = 2

func _on_BtnStartBattle_button_down():
	var trainer1
	var trainer2
	if player_index == 1:
		trainer1 = PlayerTrainer.new()
		$Battle.add_ally_trainer(trainer1)
		trainer2 = WildPokemonTrainer.new()
		$Battle.add_opponent_trainer(trainer2)
	if player_index == 2:
		trainer1 = WildPokemonTrainer.new()
		$Battle.add_opponent_trainer(trainer1)
		trainer2 = PlayerTrainer.new()
		$Battle.add_ally_trainer(trainer2)
	trainer1.pokemon_party = pokemon_party1
	trainer2.pokemon_party = pokemon_party2
	
	$Panel.visible = false
	$Battle.visible = true
	yield($Battle.start(), "completed")
	$Battle.visible = false
	$Panel.visible = true
