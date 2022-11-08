extends Reference

const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")

var battle: Reference
var fighter: Fighter
var pokemon: Reference
var team: Reference

func init_battle() -> void:
	fighter = team.teaml0.add_fighter()
	fighter.hp = pokemon.hp
	battle.battle_l1.add_effect(fighter, "FighterFunctions")
	var effect = battle.battle_l1.add_effect(fighter, "Stats")
	effect.level = pokemon.level
	effect.gender = pokemon.gender
	effect.attack = pokemon.get_attack()
	effect.defense = pokemon.get_defense()
	effect.special_attack = pokemon.get_special_attack()
	effect.special_defense = pokemon.get_special_defense()
	effect.speed = pokemon.get_speed()
	effect.weight = pokemon.pokemon.weight
	effect.happiness = pokemon.happiness
	
	var idx = 0
	for m in pokemon.get_moves():
		var move = m.move
		effect = battle.battle_l1.add_effect(fighter, "Move")
		effect.index = idx
		effect.pp = move.pp
		effect.move_name = m.move_name
		effect.move_type = move.type
		effect.move_category = move.category
		effect.move_priority = move.priority
		effect.move_effects = move.effects
		effect.possible_targets = move.possible_targets
		idx += 1

func get_move_data(move: String) -> Reference:
	return null
