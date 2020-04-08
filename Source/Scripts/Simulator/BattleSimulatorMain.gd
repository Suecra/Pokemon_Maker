extends Node

const BattleSimulator = preload("res://Scenes/Simulator/BattleSimulator.tscn")
const PokemonTeamEditor = preload("res://Scenes/Simulator/PokemonTeamEditor.tscn")
const PARTY_PATH_1 = "user://pokemon_party_1.tscn"
const PARTY_PATH_2 = "user://pokemon_party_2.tscn"

var pokemon_party

func _ready():
	var party
	if ResourceLoader.exists(PARTY_PATH_1):
		remove_child($PokemonParty1)
		party = load(PARTY_PATH_1).instance()
		party.name = "PokemonParty1"
		add_child(party)
	if ResourceLoader.exists(PARTY_PATH_2):
		remove_child($PokemonParty2)
		party = load(PARTY_PATH_2).instance()
		party.name = "PokemonParty2"
		add_child(party)
	pokemon_party = null
	show_battle_simulator()

func show_battle_simulator():
	var battle_simulator = BattleSimulator.instance()
	battle_simulator.name = "BattleSimulator"
	battle_simulator.pokemon_party1 = $PokemonParty1
	battle_simulator.pokemon_party2 = $PokemonParty2
	add_child(battle_simulator)
	battle_simulator.owner = self
	if pokemon_party != null:
		battle_simulator.save_party(pokemon_party)
	battle_simulator.connect("edit_party", self, "edit_party")

func edit_party(pokemon_party):
	self.pokemon_party = pokemon_party
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
