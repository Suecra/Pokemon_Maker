extends "res://Source/Scripts/Battle System/Layer 1/Effect.gd"

var type_id: int
var damage_factors: Dictionary

func _init() -> void:
	set_name("Type")

func _register() -> void:
	._register()
	reg("get_stab", 0, me())
	reg("get_effectiveness", 0, [L1Consts.Role.OPPONENT])

func get_stab(target: Reference, type_id: int, category: int) -> BattleNumber:
	if type_id == self.type_id:
		var stab_factor = f("get_stab_factor", [target, type_id, category], 1.5)
		return BattleMult.new(stab_factor)
	return BattleMult.new(1)

func get_effectiveness(target: Reference, type_id: int, category: int) -> BattleNumber:
	if damage_factors.has(type_id):
		return BattleMult.new(damage_factors[type_id])
	return BattleMult.new(1)
