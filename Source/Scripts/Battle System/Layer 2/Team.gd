extends Reference

const TeamL0 = preload("res://Source/Scripts/Battle System/Layer 0/Team.gd")
const Pokemon = preload("res://Source/Scripts/Battle System/Layer 2/Pokemon.gd")

var battle: Reference
var field: Reference
var trainer: Reference
var team_l0: TeamL0
var pokemon: Array
var items: Dictionary

func add_pokemon() -> Pokemon:
	var pokemon = Pokemon.new()
	pokemon.battle = battle
	pokemon.field = field
	pokemon.trainer = trainer
	pokemon.team = self
	self.pokemon.append(pokemon)
	return pokemon

func init_battle() -> void:
	var team_functions = battle.battle_l1.add_effect(team_l0, "TeamFunctions")
	team_functions.bag = items
	for p in pokemon:
		p.init_battle()
	var field_size = team_l0.field.size
	for i in range(field_size):
		pokemon[i].fighter.position = i
		pokemon[i].fighter.active = true
		var switch = battle.battle_l1.add_effect(pokemon[i].fighter, "TurnActions/Switch")
		switch.fighter = pokemon[i].fighter
