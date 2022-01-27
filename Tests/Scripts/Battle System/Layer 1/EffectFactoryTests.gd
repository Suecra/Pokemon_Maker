extends WATTest

const TestEffectFactory = preload("res://Tests/Scripts/Battle System/Layer 1/TestEffectFactory.gd")
const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")
var effect_factory: TestEffectFactory

func test_create_effect() -> void:
	var fighter = Fighter.new()
	var effect = effect_factory.create_effect("test", fighter)
	asserts.is_equal(fighter, effect.owner)

func pre() -> void:
	effect_factory = TestEffectFactory.new()
