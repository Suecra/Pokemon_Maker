extends WATTest

const BattleMax = preload("res://Source/Scripts/Battle System/Layer 1/BattleMax.gd")
var battle_max: BattleMax

func test_concat() -> void:
	var max2 = BattleMax.new(15.0)
	battle_max._concat(max2)
	asserts.is_equal(12.0, battle_max.value)
	asserts.is_equal(15.0, max2.value)
	max2 = BattleMax.new(17.0)
	battle_max._concat(max2)
	asserts.is_equal(12.0, battle_max.value)
	asserts.is_equal(17.0, max2.value)

func pre() -> void:
	battle_max = BattleMax.new(12.0)
