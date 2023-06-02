extends "res://Source/Scripts/Battle System/Layer 1/Effects/MoveEffects/METargeted.gd"

var base_damage: int
var type_id: int
var category: int

func _init() -> void:
	set_name("MEDamage")

func _register() -> void:
	._register()
	reg("hit_target", 0, me())
	reg("get_damage", 0, me())
	reg("get_damage_roll", 0, me())

func hit_target(target: Reference) -> BattleBool:
	var cat = i("get_move_category", [target, type_id, category], category)
	var type = i("get_move_type", [target, type_id, cat], type_id)
	var effectiveness = f("get_effectiveness", [target, type, cat], 1.0)
	if effectiveness == 0:
		return BattleBool.new(false)
	var damage = f("get_damage", [target, type, cat])
	delegate(target).v("damage", [damage])
	return BattleBool.new(true)

func get_damage(target: Reference, type: int, category: int) -> BattleNumber:
	var params = [target, type, category]
	var damage = f("get_base_damage", params, base_damage)
	var level = i("get_level", params)
	var attack := 0
	var defense := 0
	if category == L1Consts.MoveCategory.PHYSICAL:
		attack = f("get_attack", params)
		defense = delegate(target).f("get_defense", [self, type, category])
	elif category == L1Consts.MoveCategory.SPECIAL:
		attack = f("get_special_attack", params)
		defense = delegate(target).f("get_special_defense", [self, type, category])
	var factor_1 = f("get_damage_factor_1", params, 1.0)
	var is_crit = b("is_critical_hit", params, false)
	if not is_crit:
		var crit_chance = f("get_crit_chance", params, 0.0416)
		is_crit = random_trigger(crit_chance)
	var crit_factor := 1.0
	if is_crit:
		crit_factor = f("get_crit_factor", params, 1.5)
	var factor_2 = f("get_damage_factor_2", params, 1.0)
	var damage_roll = f("get_damage_roll", params, 1.0)
	var stab = f("get_STAB", params, 1.0)
	var factor_3 = f("get_damage_factor_3", params, 1.0)
	var type_factor = f("get_effectiveness", params, 1.0)
	
	damage = floor(((level * 2.0 / 5.0 + 2) * damage * attack / (50 * defense) * factor_1 + 2) * crit_factor * factor_2 * damage_roll * stab * type_factor * factor_3)
	
	return BattleNumber.new(damage)

func get_damage_roll(target: Reference, type_id: int, category: int) -> BattleNumber:
	return BattleNumber.new(battle.random_number(0.85, 1.15))
