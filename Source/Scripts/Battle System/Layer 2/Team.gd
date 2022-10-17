extends Reference

const TeamL0 = preload("res://Source/Scripts/Battle System/Layer 0/Team.gd")
const Pokemon = preload("res://Source/Scripts/Battle System/Layer 2/Pokemon.gd")

var battle: Reference
var team_l0: TeamL0
var pokemon: Array

func init_battle() -> void:
	battle.battle_l1.add_effect(team_l0, "TeamFunctions")
	for p in pokemon:
		p.init_battle()
	var field_size = team_l0.field.size
	for i in range(field_size):
		pokemon[i].fighter.position = i
		pokemon[i].fighter.active = true
		var switch = battle.battle_l1.add_effect(pokemon[i].fighter, "Switch")
		switch.fighter = pokemon[i].fighter
