extends "res://Source/Data/Move.gd"

const BattleAnimationDamage = preload("res://Source/Scripts/Battle/Animations/BattleAnimationDamage.gd")
const BattleAnimationFaint = preload("res://Source/Scripts/Battle/Animations/BattleAnimationFaint.gd")

var crit_level
var critical_hit
var damage_multiplier

func _hit():
	crit_level = 1
	for i in targets.size():
		var damage = _get_damage(i)
		targets[i].damage(damage)
		register_damage(targets[i], damage)
		if critical_hit:
			battle.register_message("Todkrank!")
		match damage_multiplier:
			0.25: battle.register_message("Schaden zu steigen gegen Dummies!")
			0.5: battle.register_message("Schaden zu steigen gegen Dummies!")
			2.0: battle.register_message("Schaden zu steigen gegen Profis!")
			4.0: battle.register_message("Schaden zu steigen gegen Profis!")
		if targets[i].fainted():
			register_faint(targets[i])
			battle.register_message(targets[i].nickname + " has fainted!")

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
		return 1.5
	return 1.0
	pass

func _is_critical_hit():
	match crit_level:
		1: critical_hit = Utils.trigger(0.0416)
		2: critical_hit = Utils.trigger(0.125)
		3: critical_hit = Utils.trigger(0.5)
		4: critical_hit = true
	return critical_hit

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
	damage_multiplier = get_type().get_damage_multiplier(targets[target].get_types())
	return damage_multiplier

func register_damage(target, damage):
	var damage_animation = BattleAnimationDamage.new()
	damage_animation.status_bar = target.status_bar
	damage_animation.damage = damage
	turn.register_animation(damage_animation)

func register_faint(target):
	var animation = BattleAnimationFaint.new()
	animation.pokemon = target
	battle.current_turn.register_animation(animation)