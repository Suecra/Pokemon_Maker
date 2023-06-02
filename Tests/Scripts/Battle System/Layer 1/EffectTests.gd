extends WATTest

const Effect = preload("res://Source/Scripts/Battle System/Layer 1/Effect.gd")
const TestEffectFactory = preload("res://Tests/Scripts/Battle System/Layer 1/TestEffectFactory.gd")
const EffectManager = preload("res://Source/Scripts/Battle System/Layer 1/EffectManager.gd")
const Battlefield = preload("res://Source/Scripts/Battle System/Layer 0/Battlefield.gd")
const Field = preload("res://Source/Scripts/Battle System/Layer 0/Field.gd")
const BattleNumber = preload("res://Source/Scripts/Battle System/Layer 1/BattleNumber.gd")
var effect: Reference
var effect_manager: EffectManager

func test_v() -> void:
	effect._register()
	effect.v("nudge", [])
	asserts.is_equal(1, effect.i)

func test_set_name() -> void:
	effect.set_name("Burn")
	asserts.is_true(effect.names.has("Burn"))

func test_is_type() -> void:
	effect.names.append("Flinch")
	effect.names.append("Confusion")
	asserts.is_true(effect.is_type("Flinch"))
	asserts.is_true(effect.is_type("Confusion"))

func test_reg() -> void:
	effect.reg("nudge", 1, [L1Consts.Role.BATTLEFIELD])
	asserts.is_equal(effect, effect_manager.registered_effects["nudge"][0].effect)
	asserts.is_equal(1, effect_manager.registered_effects["nudge"][0].priority)
	asserts.is_equal([L1Consts.Role.BATTLEFIELD], effect_manager.registered_effects["nudge"][0].roles)

func test_register_vars() -> void:
	effect.register_vars(["i"], [L1Consts.Role.BATTLEFIELD])
	asserts.is_equal(effect, effect_manager.registered_effects["get_i"][0].effect)
	asserts.is_equal(0, effect_manager.registered_effects["get_i"][0].priority)
	asserts.is_equal([L1Consts.Role.BATTLEFIELD], effect_manager.registered_effects["get_i"][0].roles)
	var fld = Field.new()
	effect.i = 42
	var number = effect_manager.send("get_i", [], fld, BattleNumber.new(0))
	asserts.is_equal(42, number.value)

func pre() -> void:
	var factory = TestEffectFactory.new()
	effect = factory.create_effect("", Battlefield.new())
	effect_manager = EffectManager.new()
	effect.effect_manager = effect_manager
