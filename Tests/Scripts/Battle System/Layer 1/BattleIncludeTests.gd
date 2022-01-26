extends WATTest

const BattleInclude = preload("res://Source/Scripts/Battle System/Layer 1/BattleInclude.gd")
var battle_include: BattleInclude

func test_concat() -> void:
	var in2 = BattleInclude.new([5, 10])
	battle_include._concat(in2)
	asserts.is_true(in2.value.has(5))
	asserts.is_true(in2.value.has(10))
	asserts.is_true(in2.value.has(15))

func pre() -> void:
	battle_include = BattleInclude.new([15])
