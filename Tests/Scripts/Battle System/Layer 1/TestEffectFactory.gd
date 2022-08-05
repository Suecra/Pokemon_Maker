extends "res://Source/Scripts/Battle System/Layer 1/EffectFactory.gd"

const TestEffect = preload("res://Tests/Scripts/Battle System/Layer 1/TestEffect.gd")

var cardinality := -1
var replace_mode := 0

func create_effect(name: String, owner: BattleEntity):
	var effect = TestEffect.new()
	effect.set_name(name)
	effect.owner = owner
	effect.cardinality = cardinality
	effect.replace_mode = replace_mode
	return effect
