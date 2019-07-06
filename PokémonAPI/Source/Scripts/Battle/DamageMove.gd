extends "res://Source/Data/Move.gd"

const Utils = preload("res://Source/Scripts/Utils.gd")

var crit_level

func _execute():
	crit_level = 1
	for i in targets.size():
		targets[i].damage(_get_damage(i))

func _get_damage(target: int):
	var damage = (user.level * 2 / 5 + 2) * _get_base_damage() * _get_attack() / 50 * _get_defense(target) * _get_factor1() + 2
	damage *= _get_crit_multiplier()
	damage *= get_damage_roll()
	damage *= _get_STAB_multiplier()
	damage *= _get_damage_multiplier()
	return damage

func _get_attack():
	pass

func _get_defense(target: int):
	pass

func _get_factor1():
	pass

func _get_crit_multiplier():
	if _is_critical_hit():
		return 1.5
	return 1
	pass

func _is_critical_hit():
	match crit_level:
		1: return Utils.trigger(0.0416)
		2: return Utils.trigger(0.125)
		3: return Utils.trigger(0.5)
		4: return true

func get_damage_roll():
	return rand_range(0.85, 1.0)

func _get_STAB_multiplier():
	if _is_STAB():
		return 1.5
	return 1

func _is_STAB():
	var types = user.get_types()
	for type in types:
		if type.id == get_type().id:
			return true
	return false

func _get_damage_multiplier():
	return get_type().get_damage_multiplier(user.get_types())