extends Reference

const BattleL0 = preload("res://Source/Scripts/Battle System/Layer 0/Battle.gd")
const EffectManager = preload("res://Source/Scripts/Battle System/Layer 1/EffectManager.gd")
const Effect = preload("res://Source/Scripts/Battle System/Layer 1/Effect.gd")
const EffectFactory = preload("res://Source/Scripts/Battle System/Layer 1/EffectFactory.gd")
const BattleEntity = preload("res://Source/Scripts/Battle System/Layer 0/BattleEntity.gd")

var battle_l0: BattleL0
var effect_manager: EffectManager
var effect_factory: EffectFactory
var effects: Array

func add_effect(owner: BattleEntity, name: String) -> void:
	var effect = effect_factory.create_effect(name, owner)
	effect.effect_manager = effect_manager
	effect.battle = self
	effect._register()
	effects.append(effect)

func get_effect(owner: BattleEntity, base_type: String) -> Effect:
	return null

func remove_effect(owner: BattleEntity, name: String) -> void:
	pass

func nudge_effects() -> void:
	effect_manager.send("nudge", [], battle_l0.battlefield)

func _init() -> void:
	effect_factory = EffectFactory.new()
