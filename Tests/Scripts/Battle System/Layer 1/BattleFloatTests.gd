extends WATTest

const BattleFloat = preload("res://Source/Scripts/Battle System/Layer 1/BattleFloat.gd")
var battle_float: BattleFloat

func test_concat() -> void:
	var float2 = BattleFloat.new(2.71)
	battle_float._concat(float2)
	asserts.is_equal(3.14, battle_float.value)
	asserts.is_equal(3.14, float2.value)

func pre() -> void:
	battle_float = BattleFloat.new(3.14)
