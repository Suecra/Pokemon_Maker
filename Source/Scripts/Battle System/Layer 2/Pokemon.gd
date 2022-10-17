extends Reference

const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")

var battle: Reference
var fighter: Fighter
var pokemon: Reference

func init_battle() -> void:
	battle.battle_l1.add_effect(fighter, "FighterFunctions")
	var effect = battle.battle_l1.add_effect(fighter, "Stats")
	effect.level = pokemon.level
	effect.gender = pokemon.gender
	effect.attack = pokemon.attack
	effect.defense = pokemon.defense
	effect.special_attack = pokemon.special_attack
	effect.special_defense = pokemon.special_defense
	effect.speed = pokemon.speed
	effect.weight = pokemon.species.weight
	effect.happiness = pokemon.happiness
	
	var idx = 0
	for m in pokemon.moves:
		var move = get_move_data(m)
		effect = battle.battle_l1.add_effect(fighter, "Move")
		effect.index = idx
		effect.pp = move.pp
		effect.move_name = m
		effect.move_type = move.type
		effect.move_category = move.category
		effect.move_priority = move.priority
		effect.move_effects = move.effects
		effect.possible_targets = move.possible_targets
		idx += 1

func get_move_data(move: String) -> Reference:
	return null
