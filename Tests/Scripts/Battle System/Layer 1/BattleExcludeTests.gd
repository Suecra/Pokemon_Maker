extends WATTest

const BattleExclude = preload("res://Source/Scripts/Battle System/Layer 1/BattleExclude.gd")
var battle_exclude: BattleExclude

func test_concat() -> void:
	var ex2 = BattleExclude.new([8, 16, 32])
	battle_exclude._concat(ex2)
	asserts.is_true(ex2.value.has(8))
	asserts.is_false(ex2.value.has(16))
	asserts.is_true(ex2.value.has(32))

func pre() -> void:
	battle_exclude = BattleExclude.new([16])
