extends "res://Source/Scripts/Battle System/Layer 1/EffectFactory.gd"

const TestEffect = preload("res://Tests/Scripts/Battle System/Layer 1/TestEffect.gd")

func create_effect(name: String, owner: BattleEntity):
	var effect = TestEffect.new()
	effect.owner = owner
	return effect
