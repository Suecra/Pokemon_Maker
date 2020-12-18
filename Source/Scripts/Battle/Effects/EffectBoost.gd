extends "res://Source/Scripts/Battle/Effect.gd"

class_name EffectBoost

enum Stat {ATTACK, DEFENSE, SPECIAL_ATTACK, SPECIAL_DEFENSE, SPEED}

export(int, -6, 6) var attack_boost = 0
export(int, -6, 6) var defense_boost = 0
export(int, -6, 6) var special_attack_boost = 0
export(int, -6, 6) var special_defense_boost = 0
export(int, -6, 6) var speed_boost = 0
export(int, -6, 6) var accuracy_boost = 0
export(int, -6, 6) var evasion_boost = 0

func _execute(pokemon: Node) -> void:
	pokemon.boost_stat(0, attack_boost)
	pokemon.boost_stat(1, defense_boost)
	pokemon.boost_stat(2, special_attack_boost)
	pokemon.boost_stat(3, special_defense_boost)
	pokemon.boost_stat(4, speed_boost)
