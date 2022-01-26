extends WATTest

const BattleMult = preload("res://Source/Scripts/Battle System/Layer 1/BattleMult.gd")
var battle_mult: BattleMult

func test_concat() -> void:
	var mult2 = BattleMult.new(8.3)
	battle_mult._concat(mult2)
	asserts.is_equal(4, battle_mult.value)
	asserts.is_equal(33.2, mult2.value)

func pre() -> void:
	battle_mult = BattleMult.new(4)
