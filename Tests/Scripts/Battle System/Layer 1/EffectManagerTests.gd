extends WATTest

const EffectManager = preload("res://Source/Scripts/Battle System/Layer 1/EffectManager.gd")
const TestEffect = preload("res://Tests/Scripts/Battle System/Layer 1/TestEffect.gd")
const TestEffect2 = preload("res://Tests/Scripts/Battle System/Layer 1/TestEffect2.gd")
const RegisteredEffect = preload("res://Source/Scripts/Battle System/Layer 1/RegisteredEffect.gd")
const BattleFloat = preload("res://Source/Scripts/Battle System/Layer 1/BattleFloat.gd")
const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")
const Field = preload("res://Source/Scripts/Battle System/Layer 0/Field.gd")
var effect_manager: EffectManager

func test_send() -> void:
	var f1 = Fighter.new()
	var f2 = Fighter.new()
	var fld = Field.new()
	var e1 = TestEffect.new()
	var e2 = TestEffect.new()
	f1.field = fld
	f2.field = fld
	e1.owner = f1
	e2.owner = f2
	effect_manager.registered_effects["nudge"] = []
	effect_manager.registered_effects["nudge"].append(RegisteredEffect.new(e1, 2, L1Consts.SenderType.SELF_OR_ALLY))
	effect_manager.registered_effects["nudge"].append(RegisteredEffect.new(e2, 1, L1Consts.SenderType.SELF))
	effect_manager.send("nudge", [], f1)
	asserts.is_equal(1, e1.i)
	asserts.is_equal(0, e2.i)
	e1.i = 0
	e2.i = 0
	effect_manager.send("nudge", [], f2)
	asserts.is_equal(1, e1.i)
	asserts.is_equal(1, e2.i)

func test_call_method() -> void:
	var effect = TestEffect2.new()
	var result = BattleFloat.new(2)
	effect_manager.call_method(effect, "call_test", [5], result)
	asserts.is_equal(12, result.value)
	effect_manager.call_method(effect, "call_test", [12], result)
	asserts.is_equal(36, result.value)

func test_register() -> void:
	var effect = TestEffect.new()
	effect_manager.register(effect, "nudge", 1, 2)
	asserts.is_true(effect_manager.registered_effects.has("nudge"))
	asserts.is_equal(effect, effect_manager.registered_effects["nudge"][0].effect)
	asserts.is_equal(1, effect_manager.registered_effects["nudge"][0].priority)
	asserts.is_equal(2, effect_manager.registered_effects["nudge"][0].sender_type)

func test_sort_registered_effects() -> void:
	effect_manager.registered_effects["nudge"] = []
	effect_manager.registered_effects["nudge"].append(RegisteredEffect.new(TestEffect.new(), 4, L1Consts.SenderType.SELF))
	effect_manager.registered_effects["nudge"].append(RegisteredEffect.new(TestEffect.new(), 2, L1Consts.SenderType.SELF))
	effect_manager.registered_effects["nudge"].append(RegisteredEffect.new(TestEffect.new(), 25, L1Consts.SenderType.SELF))
	effect_manager.registered_effects["nudge"].append(RegisteredEffect.new(TestEffect.new(), 13, L1Consts.SenderType.SELF))
	effect_manager.registered_effects["nudge"].sort_custom(EffectManager.RegisteredEffectSorter, "sort")
	asserts.is_equal(2, effect_manager.registered_effects["nudge"][0].priority)
	asserts.is_equal(4, effect_manager.registered_effects["nudge"][1].priority)
	asserts.is_equal(13, effect_manager.registered_effects["nudge"][2].priority)
	asserts.is_equal(25, effect_manager.registered_effects["nudge"][3].priority)

func pre() -> void:
	effect_manager = EffectManager.new()
