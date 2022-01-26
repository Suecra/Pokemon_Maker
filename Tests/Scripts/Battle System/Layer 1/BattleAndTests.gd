extends WATTest

const BattleAnd = preload("res://Source/Scripts/Battle System/Layer 1/BattleAnd.gd")
var battle_and: BattleAnd

func test_concat() -> void:
	var and2 = BattleAnd.new(false)
	battle_and._concat(and2)
	asserts.is_true(battle_and.value)
	asserts.is_false(and2.value)
	and2 = BattleAnd.new(true)
	battle_and._concat(and2)
	asserts.is_true(battle_and.value)
	asserts.is_true(and2.value)
	battle_and.value = false
	BattleAnd.new(false)
	battle_and._concat(and2)
	asserts.is_false(battle_and.value)
	asserts.is_false(and2.value)
	and2 = BattleAnd.new(true)
	battle_and._concat(and2)
	asserts.is_false(battle_and.value)
	asserts.is_false(and2.value)

func pre() -> void:
	battle_and = BattleAnd.new(true)
