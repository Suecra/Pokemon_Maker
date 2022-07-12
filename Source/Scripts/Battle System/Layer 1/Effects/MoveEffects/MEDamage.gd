extends "res://Source/Scripts/Battle System/Layer 1/Effects/MoveEffects/METargeted.gd"

var base_damage: int
var type_id: int
var category: int

func _init() -> void:
	set_name("MEDamage")

func _register() -> void:
	._register()
	reg("hit_target", 0, L1Consts.SenderType.SELF)
	reg("get_damage", 0, L1Consts.SenderType.SELF)
	reg("get_damage_roll", 0, L1Consts.SenderType.SELF)

func hit_target(target: Reference) -> void:
	var damage = n("get_damage", [target])
	target.damage(damage)

func get_damage(target: Reference) -> BattleNumber:
	var cat = n("get_move_category", [target, type_id, category], category).value
	var type = n("get_move_type", [target, type_id, cat], type_id).value
	var params = [target, type, cat]
	var damage = n("get_base_damage", params, base_damage).value
	var level = n("get_level", params).value
	var attack := 0
	var defense := 0
	if cat == L1Consts.MoveCategory.PHYSICAL:
		attack = n("get_attack", params).value
		defense = delegate(target).n("get_defense", [self, type, cat]).value
	elif cat == L1Consts.MoveCategory.SPECIAL:
		attack = n("get_special_attack", params).value
		defense = delegate(target).n("get_special_defense", [self, type, cat]).value
	var factor_1 = n("get_damage_factor_1", params, 1.0).value
	var is_crit = b("is_critical_hit", params, false).value
	if not is_crit:
		var crit_chance = n("get_crit_chance", params, 0.0416)
		is_crit = random_trigger(crit_chance)
	var crit_factor := 1.0
	if is_crit:
		crit_factor = n("get_crit_factor", params, 1.5).value
	var factor_2 = n("get_damage_factor_2", params, 1.0).value
	var damage_roll = n("get_damage_roll", params, 1.0).value
	var stab = n("get_STAB", params, 1.0).value
	var type_factor = n("get_effectiveness", params, 1.0).value
	var factor_3 = n("get_damage_factor_3", params, 1.0).value
	
	damage = floor(((level * 2.0 / 5.0 + 2) * damage * attack / (50 * defense) * factor_1 + 2) * crit_factor * factor_2 * damage_roll * stab * type_factor * factor_3)
	
	return BattleNumber.new(damage)

func get_damage_roll(target: Reference, type_id: int, category: int) -> BattleNumber:
	return BattleNumber.new(battle.random_number(0.85, 1.15))
