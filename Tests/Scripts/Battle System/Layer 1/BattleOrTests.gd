extends WATTest

const BattleOr = preload("res://Source/Scripts/Battle System/Layer 1/BattleOr.gd")
var battle_or: BattleOr

func test_concat() -> void:
	var or2 = BattleOr.new(false)
	battle_or._concat(or2)
	asserts.is_true(battle_or.value)
	asserts.is_true(or2.value)
	or2 = BattleOr.new(true)
	battle_or._concat(or2)
	asserts.is_true(battle_or.value)
	asserts.is_true(or2.value)
	battle_or.value = false
	or2 = BattleOr.new(false)
	battle_or._concat(or2)
	asserts.is_false(battle_or.value)
	asserts.is_false(or2.value)
	or2 = BattleOr.new(true)
	battle_or._concat(or2)
	asserts.is_false(battle_or.value)
	asserts.is_true(or2.value)

func pre() -> void:
	battle_or = BattleOr.new(true)
