extends "res://Source/Data/Move.gd"

var crit_level

func _hit():
	crit_level = 1
	for i in targets.size():
		targets[i].damage(_get_damage(i))

func _get_damage(target: int):
	var damage = floor(user.level * 2 / 5) + 2
	damage *= _get_base_damage()
	damage *= _get_attack()
	damage = floor(damage / (50 * _get_defense(target)))
	damage = floor(damage * _get_factor1())
	damage += 2
	damage = floor(damage * _get_crit_multiplier())
	damage = floor(damage * get_damage_roll())
	damage = floor(damage * _get_STAB_multiplier())
	damage = floor(damage * _get_damage_multiplier(target))
	damage = max(damage, 1)
	return damage

func _get_attack():
	pass

func _get_defense(target: int):
	pass

func _get_factor1():
	if targets.size() > 1:
		return 0.75
	return 1.0

func _get_crit_multiplier():
	if _is_critical_hit():
		print("A critical hit!")
		return 1.5
	return 1.0
	pass

func _is_critical_hit():
	match crit_level:
		1: return Utils.trigger(0.0416)
		2: return Utils.trigger(0.125)
		3: return Utils.trigger(0.5)
		4: return true

func get_damage_roll():
	return float(randi() % 16 + 85) / 100

func _get_STAB_multiplier():
	if _is_STAB():
		return 1.5
	return 1.0

func _is_STAB():
	var types = user.get_types()
	for type in types:
		if type.id == get_type().id:
			return true
	return false

func _get_damage_multiplier(target):
	return get_type().get_damage_multiplier(targets[target].get_types())