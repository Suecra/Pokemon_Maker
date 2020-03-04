extends Node

const BattleSimulator = preload("res://Scenes/Simulator/BattleSimulator.tscn")
const PokemonTeamEditor = preload("res://Scenes/Simulator/PokemonTeamEditor.tscn")

func _ready():
	show_battle_simulator()

func show_battle_simulator():
	var battle_simulator = BattleSimulator.instance()
	battle_simulator.name = "BattleSimulator"
	battle_simulator.pokemon_party1 = $PokemonParty1
	battle_simulator.pokemon_party2 = $PokemonParty2
	add_child(battle_simulator)
	battle_simulator.owner = self
	battle_simulator.connect("edit_party", self, "edit_party")

func edit_party(pokemon_party):
	remove_child($BattleSimulator)
	var team_editor = PokemonTeamEditor.instance()
	team_editor.name = "TeamEditor"
	team_editor.owner = self
	team_editor.pokemon_party = pokemon_party
	add_child(team_editor)
	team_editor.connect("back", self, "back")

func back():
	remove_child($TeamEditor)
	show_battle_simulator()