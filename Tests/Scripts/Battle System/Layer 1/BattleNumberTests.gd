extends WATTest

const BattleNumber = preload("res://Source/Scripts/Battle System/Layer 1/BattleNumber.gd")
var battle_number: BattleNumber

func test_concat() -> void:
	var number2 = BattleNumber.new(2.71)
	battle_number._concat(number2)
	asserts.is_equal(3.14, battle_number.value)
	asserts.is_equal(3.14, number2.value)

func pre() -> void:
	battle_number = BattleNumber.new(3.14)
