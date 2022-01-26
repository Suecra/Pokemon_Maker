extends WATTest

const BattleInt = preload("res://Source/Scripts/Battle System/Layer 1/BattleInt.gd")
var battle_int: BattleInt

func test_concat() -> void:
	var int2 = BattleInt.new(2)
	battle_int._concat(int2)
	asserts.is_equal(1, battle_int.value)
	asserts.is_equal(1, int2.value)

func pre() -> void:
	battle_int = BattleInt.new(1)
