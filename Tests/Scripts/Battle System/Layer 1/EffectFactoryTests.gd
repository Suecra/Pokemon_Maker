extends WATTest

const EffectFactory = preload("res://Source/Scripts/Battle System/Layer 1/EffectFactory.gd")
var effect_factory: EffectFactory

func test_create_effect() -> void:
	pass

func pre() -> void:
	effect_factory = EffectFactory.new()
