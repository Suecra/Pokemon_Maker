extends Node

const MessageBox = preload("res://Source/Scripts/Common/Textboxes/MessageBox.gd")
const PrioritySorter = preload("res://Source/Scripts/Battle/PrioritySorter.gd")

var playerTrainer
var opponentTrainer

func _on_Button2_button_down():
	$Interface.visible = false
	$Battle.visible = true
	yield($Battle.start(), "completed")
	$Battle.visible = false
	$Interface.visible = true

func _ready():
	randomize()
	playerTrainer = load("res://Scenes/Trainer/PlayerTrainer.tscn").instance()
	opponentTrainer = load("res://Scenes/Trainer/WildPokemonTrainer.tscn").instance()
	$Battle.add_ally_trainer(playerTrainer)
	$Battle.add_opponent_trainer(opponentTrainer)

func _on_AddPlayerPokemon_button_down():
	if ResourceLoader.exists("res://Source/Data/Pokemon/" + $Interface/PokemonName.text + ".tscn"):
		var pokemon = load("res://Source/Scripts/Battle/Pokemon.gd").new()
		playerTrainer.pokemon_party.add_child(pokemon)
		pokemon.level = $Interface/PokemonLevel.value
		pokemon.species = load("res://Source/Data/Pokemon/" + $Interface/PokemonName.text + ".tscn")
		pokemon.nature = load("res://Source/Data/Nature/quirky.tscn")
		pokemon.get_random_ivs()
		var movepool = load("res://Source/Scripts/Battle/Movepool.gd").new()
		movepool.owner = pokemon
		movepool.name = "Movepool"
		pokemon.add_child(movepool)
		pokemon.nickname = $Interface/PokemonName.text
		pokemon.calculate_stats()
		pokemon.current_hp = 9999
		var moves = pokemon.get_last_learnable_moves()
		for m in moves:
			pokemon.get_movepool().add_move(m.move)
		$Interface/PokemonLabel.text += $Interface/PokemonName.text + "\n"

func _on_AddPlayerPokemon2_button_down():
	if ResourceLoader.exists("res://Source/Data/Pokemon/" + $Interface/PokemonName2.text + ".tscn"):
		var pokemon = load("res://Source/Scripts/Battle/Pokemon.gd").new()
		opponentTrainer.pokemon_party.add_child(pokemon)
		pokemon.level = $Interface/PokemonLevel2.value
		pokemon.species = load("res://Source/Data/Pokemon/" + $Interface/PokemonName2.text + ".tscn")
		pokemon.nature = load("res://Source/Data/Nature/quirky.tscn")
		pokemon.get_random_ivs()
		var movepool = load("res://Source/Scripts/Battle/Movepool.gd").new()
		movepool.owner = pokemon
		movepool.name = "Movepool"
		pokemon.add_child(movepool)
		pokemon.nickname = $Interface/PokemonName2.text
		pokemon.calculate_stats()
		pokemon.current_hp = 9999
		var moves = pokemon.get_last_learnable_moves()
		for m in moves:
			pokemon.get_movepool().add_move(m.move)
		$Interface/PokemonLabel2.text += $Interface/PokemonName2.text + "\n"

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch:
		if event.pressed:
			Input.action_press("ui_accept")
		else:
			Input.action_release("ui_accept")
