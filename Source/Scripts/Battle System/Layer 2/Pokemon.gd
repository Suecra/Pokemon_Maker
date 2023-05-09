extends Reference

const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")

var battle: Reference
var field: Reference
var trainer: Reference
var team: Reference
var fighter: Fighter
var pokemon

func init_battle() -> void:
	battle.battle_l1.add_effect(fighter, "FighterFunctions")
	var effect = battle.battle_l1.add_effect(fighter, "Stats")
	pokemon.load_species()
	fighter.hp = pokemon.get_hp()
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
		m.load_move_data()
		var move = m.move_data
		effect = battle.battle_l1.add_effect(fighter, "Move")
		effect.index = idx
		effect.pp = move.pp
		effect.move_name = m.move_name
		effect.move_type = move.type_id
		effect.move_category = move.damage_class
		effect.move_priority = move.priority
		effect.move_effects = move.effect_array
		effect.target_type = move.target_type
		idx += 1

func get_move_data(move: String) -> Reference:
	return null
