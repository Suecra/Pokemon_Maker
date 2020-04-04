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
		-6: return int(floor(stat * 0.25))
		-5: return int(floor(stat * 0.286))
		-4: return int(floor(stat * 0.333))
		-3: return int(floor(stat * 0.40))
		-2: return int(floor(stat * 0.50))
		-1: return int(floor(stat * 0.667))
		0: return int(stat)
		1: return int(floor(stat * 1.5))
		2: return int(floor(stat * 2))
		3: return int(floor(stat * 2.5))
		4: return int(floor(stat * 3))
		3: return int(floor(stat * 3.5))
		4: return int(floor(stat * 4))

func get_boosted_stat_acc_eva(amount: int):
	match amount:
		-6: return 0.33
		-5: return 0.38
		-4: return 0.43
		-3: return 0.5
		-2: return 0.6
		-1: return 0.75
		0: return 1.0
		1: return 1.33
		2: return 1.67
		3: return 2
		4: return 2.33
		5: return 2.67
		6: return 3

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