extends Reference

const BattleL0 = preload("res://Source/Scripts/Battle System/Layer 0/Battle.gd")
const EffectManager = preload("res://Source/Scripts/Battle System/Layer 1/EffectManager.gd")
const Effect = preload("res://Source/Scripts/Battle System/Layer 1/Effect.gd")

var battle_l0: BattleL0
var effect_manager: EffectManager
var effects: Array

func add_effect(effect: Effect) -> void:
	effect.effect_manager = effect_manager
	effect._register()
	effects.append(effect)

func nudge_effects() -> void:
	effect_manager.send("nudge", [], battle_l0.battlefield)
