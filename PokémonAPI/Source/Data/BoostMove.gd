extends "res://Source/Data/StatusMove.gd"

enum Stat {ATTACK, DEFENSE, SPECIAL_ATTACK, SPECIAL_DEFENSE, SPEED}

export(int, -6, 6) var attack_boost = 0
export(int, -6, 6) var defense_boost = 0
export(int, -6, 6) var special_attack_boost = 0
export(int, -6, 6) var special_defense_boost = 0
export(int, -6, 6) var speed_boost = 0
export(int, -6, 6) var accuracy_boost = 0
export(int, -6, 6) var evasion_boost = 0

func _hit(target):
	boost_stat(target, 0, attack_boost)
	boost_stat(target, 1, defense_boost)
	boost_stat(target, 2, special_attack_boost)
	boost_stat(target, 3, special_defense_boost)
	boost_stat(target, 4, speed_boost)

func boost_stat(target, stat, amount):
	if amount != 0:
		target.boost_stat(stat, amount)
		var base_message = target.nickname + "'s " + get_stat_name(stat)
		if amount > 1:
			battle.register_message(base_message + " rose harshly!")
		elif amount > 0:
			battle.register_message(base_message + " rose!")
		elif amount < -1:
			battle.register_message(base_message + " harshly fell!")
		else:
			battle.register_message(base_message + " fell!")

func get_stat_name(stat):
	match stat:
		Stat.ATTACK: return "attack"
		Stat.DEFENSE: return "defense"
		Stat.SPECIAL_ATTACK: return "special_attack"
		Stat.SPECIAL_DEFENSE: return "special_defense"
		Stat.SPEED: return "speed"
