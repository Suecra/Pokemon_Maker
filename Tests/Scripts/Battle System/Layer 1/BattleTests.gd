extends WATTest

const Battle = preload("res://Source/Scripts/Battle System/Layer 1/Battle.gd")
const BattleL0 = preload("res://Source/Scripts/Battle System/Layer 0/Battle.gd")
const Effect = preload("res://Source/Scripts/Battle System/Layer 1/Effect.gd")
const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")
const EffectManager = preload("res://Source/Scripts/Battle System/Layer 1/EffectManager.gd")
const TestEffectFactory = preload("res://Tests/Scripts/Battle System/Layer 1/TestEffectFactory.gd")
const Battlefield = preload("res://Source/Scripts/Battle System/Layer 0/Battlefield.gd")
const RegisteredEffect = preload("res://Source/Scripts/Battle System/Layer 1/RegisteredEffect.gd")
var battle: Battle

func test_get_effects() -> void:
	var f1 = Fighter.new()
	var f2 = Fighter.new()
	var e1 = Effect.new()
	var e2 = Effect.new()
	e1.owner = f1
	e2.owner = f2
	e1.names = ["TestEffect1"]
	e2.names = ["TestEffect1", "TestEffect2"]
	battle.effects[f1] = [e1]
	battle.effects[f2] = [e2]
	var effects = battle.get_effects(f1, "TestEffect1")
	asserts.is_true(effects.has(e1))
	asserts.is_false(effects.has(e2))
	effects = battle.get_effects(f1, "TestEffect2")
	asserts.is_false(effects.has(e1))
	asserts.is_false(effects.has(e2))
	effects = battle.get_effects(f2, "TestEffect1")
	asserts.is_false(effects.has(e1))
	asserts.is_true(effects.has(e2))
	effects = battle.get_effects(f2, "TestEffect2")
	asserts.is_false(effects.has(e1))
	asserts.is_true(effects.has(e2))

func test_add_effect() -> void:
	var f1 = Fighter.new()
	var f2 = Fighter.new()
	battle.effect_factory.cardinality = 2
	var e1 = battle.add_effect(f1, "Test")
	var e2 = battle.add_effect(f2, "Test")
	asserts.is_true(battle.effects.has(f1))
	asserts.is_true(battle.effects.has(f2))
	asserts.is_true(battle.effects[f1].has(e1))
	asserts.is_true(battle.effects[f2].has(e2))
	asserts.is_true(battle.effect_manager.registered_effects.has("nudge"))
	asserts.is_equal(e1, battle.effect_manager.registered_effects["nudge"][0].effect)
	asserts.is_equal(e2, battle.effect_manager.registered_effects["nudge"][1].effect)
	
	var e3 = battle.add_effect(f1, "Test")
	asserts.is_true(battle.effects[f1].has(e3))
	battle.effect_factory.replace_mode = L1Consts.EffectReplaceMode.NONE
	var e4 = battle.add_effect(f1, "Test")
	asserts.is_equal(e3, e4)
	battle.effect_factory.replace_mode = L1Consts.EffectReplaceMode.FIFO
	e4 = battle.add_effect(f1, "Test")
	asserts.is_false(battle.effects[f1].has(e1))
	asserts.is_true(battle.effects[f1].has(e3))
	asserts.is_true(battle.effects[f1].has(e4))
	battle.effect_factory.replace_mode = L1Consts.EffectReplaceMode.LIFO
	var e5 = battle.add_effect(f1, "Test")
	asserts.is_true(battle.effects[f1].has(e3))
	asserts.is_false(battle.effects[f1].has(e4))
	asserts.is_true(battle.effects[f1].has(e5))

func test_remove_effects() -> void:
	var f1 = Fighter.new()
	var f2 = Fighter.new()
	var e1 = Effect.new()
	var e2 = Effect.new()
	var e3 = Effect.new()
	e1.owner = f1
	e2.owner = f2
	e3.owner = f2
	e1.names = ["TestEffect1"]
	e2.names = ["TestEffect1", "TestEffect2"]
	e3.names = ["TestEffect2"]
	battle.effects[f1] = [e1]
	battle.effects[f2] = [e2, e3]
	battle.effect_manager.registered_effects["test"] = []
	battle.effect_manager.registered_effects["test"].append(RegisteredEffect.new(e1, 1, 0))
	battle.remove_effects(f1, "TestEffect1")
	asserts.is_false(battle.effects[f1].has(e1))
	asserts.is_true(battle.effects[f2].has(e2))
	asserts.is_true(battle.effects[f2].has(e3))
	asserts.is_false(battle.effect_manager.registered_effects.has("test"))
	battle.remove_effects(f2, "TestEffect1")
	asserts.is_false(battle.effects[f2].has(e2))
	asserts.is_true(battle.effects[f2].has(e3))
	battle.remove_effects(f2, "TestEffect2")
	asserts.is_false(battle.effects[f2].has(e3))

func test_nudge_effects() -> void:
	var f1 = Fighter.new()
	var e1 = battle.add_effect(f1, "")
	battle.nudge_effects()
	asserts.is_equal(1, e1.i)

func pre() -> void:
	battle = Battle.new()
	battle.effect_manager = EffectManager.new()
	battle.effect_factory = TestEffectFactory.new()
	battle.battle_l0 = BattleL0.new()
	battle.battle_l0.battlefield = Battlefield.new()
