extends WATTest

const BattleMin = preload("res://Source/Scripts/Battle System/Layer 1/BattleMin.gd")
var battle_min: BattleMin

func test_concat() -> void:
	var min2 = BattleMin.new(12.0)
	battle_min._concat(min2)
	asserts.is_equal(15.0, battle_min.value)
	asserts.is_equal(12.0, min2.value)
	min2 = BattleMin.new(3.0)
	battle_min._concat(min2)
	asserts.is_equal(15.0, battle_min.value)
	asserts.is_equal(3.0, min2.value)

func pre() -> void:
	battle_min = BattleMin.new(15.0)
