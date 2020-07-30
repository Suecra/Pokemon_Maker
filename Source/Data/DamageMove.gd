extends "res://Source/Data/Move.gd"

var crit_level: int
var critical_hit: bool
var damage_multiplier: float

func _hit(target: Node) -> void:
	crit_level = 1
	var messages = []
	var damage = _get_damage(target)
	if critical_hit:
		messages.append("A critical hit!")
	match damage_multiplier:
		0.25: messages.append("It's not very effective!")
		0.5: messages.append("It's not very effective!")
		2.0: messages.append("It's very effective!")
		4.0: messages.append("It's very effective!")
	target.damage(damage, messages)
	._hit(target)

func _get_damage(target: Node) -> int:
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

func _get_attack() -> int:
	return 0

func _get_defense(target: Node) -> int:
	return 0

func _get_factor1() -> float:
	if targets.size() > 1:
		return 0.75
	return 1.0

func _get_crit_multiplier() -> float:
	if _is_critical_hit():
		return 1.5
	return 1.0
	pass

func _is_critical_hit() -> bool:
	match crit_level:
		1: critical_hit = Utils.trigger(0.0416)
		2: critical_hit = Utils.trigger(0.125)
		3: critical_hit = Utils.trigger(0.5)
		4: critical_hit = true
	return critical_hit

func get_damage_roll() -> float:
	return float(randi() % 16 + 85) / 100

func _get_STAB_multiplier() -> float:
	if _is_STAB():
		return 1.5
	return 1.0

func _is_STAB() -> bool:
	var types = user.get_types()
	for type in types:
		if type.id == get_type().id:
			return true
	return false

func _get_damage_multiplier(target: Node) -> float:
	damage_multiplier = get_type().get_damage_multiplier(target.get_types())
	return damage_multiplier
