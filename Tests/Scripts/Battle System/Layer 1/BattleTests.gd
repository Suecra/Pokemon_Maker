extends WATTest

const Battle = preload("res://Source/Scripts/Battle System/Layer 1/Battle.gd")
const BattleL0 = preload("res://Source/Scripts/Battle System/Layer 0/Battle.gd")
const Effect = preload("res://Source/Scripts/Battle System/Layer 1/Effect.gd")
const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")
const EffectManager = preload("res://Source/Scripts/Battle System/Layer 1/EffectManager.gd")
const TestEffectFactory = preload("res://Tests/Scripts/Battle System/Layer 1/TestEffectFactory.gd")
var battle: Battle

func test_get_effects() -> void:
	var f1 = Fighter.new()
	var f2 = Fighter.new()
	var e1 = Effect.new(f1)
	var e2 = Effect.new(f2)
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
	var e1 = battle.add_effect(f1, "TestEffect1")
	var e2 = battle.add_effect(f2, "TestEffect2")
	#asserts.was_called(e1, "_register")
	#asserts.was_called(e2, "_register")
	asserts.is_true(battle.effects.has(f1))
	asserts.is_true(battle.effects.has(f2))
	asserts.is_true(battle.effects[f1].has(e1))
	asserts.is_true(battle.effects[f2].has(e2))

func test_remove_effects() -> void:
	var f1 = Fighter.new()
	var f2 = Fighter.new()
	var e1 = Effect.new(f1)
	var e2 = Effect.new(f2)
	var e3 = Effect.new(f2)
	e1.names = ["TestEffect1"]
	e2.names = ["TestEffect1", "TestEffect2"]
	e3.names = ["TestEffect2"]
	battle.effects[f1] = [e1]
	battle.effects[f2] = [e2, e3]
	battle.remove_effects(f1, "TestEffect1")
	asserts.is_false(battle.effects[f1].has(e1))
	asserts.is_true(battle.effects[f2].has(e2))
	asserts.is_true(battle.effects[f2].has(e3))
	battle.remove_effects(f2, "TestEffect1")
	asserts.is_false(battle.effects[f2].has(e2))
	asserts.is_true(battle.effects[f2].has(e3))
	battle.remove_effects(f2, "TestEffect2")
	asserts.is_false(battle.effects[f2].has(e3))

func test_nudge_effects() -> void:
	var director = direct.script(Battle)
	var double = director.double()
	double.battle_l0 = BattleL0.new()
	double.effect_manager = EffectManager.new()
	double.nudge_effects()
	asserts.was_called(double, "send")

func pre() -> void:
	battle = Battle.new()
	battle.effect_manager = EffectManager.new()
	battle.effect_factory = TestEffectFactory.new()
	battle.battle_l0 = BattleL0.new()
