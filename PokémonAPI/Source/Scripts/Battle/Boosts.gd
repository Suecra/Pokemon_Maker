extends Node

enum Stat {ATTACK, DEFENSE, SPECIAL_ATTACK, SPECIAL_DEFENSE, SPEED}

var attack_boost: int
var defense_boost: int
var special_attack_boost: int
var special_defense_boost: int
var speed_boost: int

var pokemon

func get_boosted_stat(stat: int, amount: int):
	match amount:
		-6: return floor(stat * 0.25)
		-5: return floor(stat * 0.286)
		-4: return floor(stat * 0.333)
		-3: return floor(stat * 0.40)
		-2: return floor(stat * 0.50)
		-1: return floor(stat * 0.667)
		0: return stat
		1: return floor(stat * 1.5)
		2: return floor(stat * 2)
		3: return floor(stat * 2.5)
		4: return floor(stat * 3)
		3: return floor(stat * 3.5)
		4: return floor(stat * 4)

func boost_stats():
	pokemon.current_attack = get_boosted_stat(pokemon.attack, attack_boost)
	pokemon.current_defense = get_boosted_stat(pokemon.defense, defense_boost)
	pokemon.current_special_attack = get_boosted_stat(pokemon.special_attack, special_attack_boost)
	pokemon.current_special_defense = get_boosted_stat(pokemon.special_defense, special_defense_boost)
	pokemon.current_speed = get_boosted_stat(pokemon.speed, speed_boost)

func reset():
	attack_boost = 0
	defense_boost = 0
	special_attack_boost = 0
	special_defense_boost = 0
	speed_boost = 0
	boost_stats()