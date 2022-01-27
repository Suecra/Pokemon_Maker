extends Reference

const BattleL0 = preload("res://Source/Scripts/Battle System/Layer 0/Battle.gd")
const EffectManager = preload("res://Source/Scripts/Battle System/Layer 1/EffectManager.gd")
const Effect = preload("res://Source/Scripts/Battle System/Layer 1/Effect.gd")
const EffectFactory = preload("res://Source/Scripts/Battle System/Layer 1/EffectFactory.gd")
const BattleEntity = preload("res://Source/Scripts/Battle System/Layer 0/BattleEntity.gd")

var battle_l0: BattleL0
var effect_manager: EffectManager
var effect_factory: EffectFactory
var effects: Dictionary

func add_effect(owner: BattleEntity, name: String) -> Effect:
	if not effects.has(owner):
		effects[owner] = []
	var effect = effect_factory.create_effect(name, owner)
	effect.effect_manager = effect_manager
	effect.battle = self
	effect._register()
	effects[owner].append(effect)
	return effect

func get_effects(owner: BattleEntity, name: String) -> Array:
	var result = []
	if effects.has(owner):
		var effect_list = effects[owner]
		for effect in effect_list:
			if effect.is_type(name):
				result.append(effect)
	return result

func remove_effects(owner: BattleEntity, name: String) -> void:
	if effects.has(owner):
		var effect_list = effects[owner]
		var i = 0
		while i < effect_list.size():
			var effect = effect_list[i]
			if effect.is_type(name):
				effect_list.erase(effect)
			else:
				i += 1

func nudge_effects() -> void:
	effect_manager.send("nudge", [], battle_l0.battlefield)

func _init() -> void:
	effect_factory = EffectFactory.new()
