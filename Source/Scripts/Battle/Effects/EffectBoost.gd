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

func _save_to_json(data: Dictionary) -> void:
	if guaranteed:
		data["meta"]["stat_chance"] = 0
	else:
		data["meta"]["stat_chance"] = int(chance * 100)
	data["stat_changes"] = []

	var sc = data["stat_changes"]
	if attack_boost != 0:
		sc.append({})
		sc[sc.size() - 1]["change"] = attack_boost
		sc[sc.size() - 1]["stat"] = {}
		sc[sc.size() - 1]["stat"]["name"] = "attack"
	if defense_boost != 0:
		sc.append({})
		sc[sc.size() - 1]["change"] = defense_boost
		sc[sc.size() - 1]["stat"] = {}
		sc[sc.size() - 1]["stat"]["name"] = "defense"
	if special_attack_boost != 0:
		sc.append({})
		sc[sc.size() - 1]["change"] = special_attack_boost
		sc[sc.size() - 1]["stat"] = {}
		sc[sc.size() - 1]["stat"]["name"] = "special_attack"
	if special_defense_boost != 0:
		sc.append({})
		sc[sc.size() - 1]["change"] = special_defense_boost
		sc[sc.size() - 1]["stat"] = {}
		sc[sc.size() - 1]["stat"]["name"] = "special_defense"
	if speed_boost != 0:
		sc.append({})
		sc[sc.size() - 1]["change"] = speed_boost
		sc[sc.size() - 1]["stat"] = {}
		sc[sc.size() - 1]["stat"]["name"] = "speed"
	if accuracy_boost != 0:
		sc.append({})
		sc[sc.size() - 1]["change"] = accuracy_boost
		sc[sc.size() - 1]["stat"] = {}
		sc[sc.size() - 1]["stat"]["name"] = "accuracy"
	if evasion_boost != 0:
		sc.append({})
		sc[sc.size() - 1]["change"] = evasion_boost
		sc[sc.size() - 1]["stat"] = {}
		sc[sc.size() - 1]["stat"]["name"] = "evasion"
