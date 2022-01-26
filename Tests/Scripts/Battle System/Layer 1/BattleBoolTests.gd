extends WATTest

const BattleBool = preload("res://Source/Scripts/Battle System/Layer 1/BattleBool.gd")
var battle_bool: BattleBool

func test_concat() -> void:
	var bool2 = BattleBool.new(true)
	battle_bool._concat(bool2)
	asserts.is_equal(false, battle_bool.value)
	asserts.is_equal(false, bool2.value)

func pre() -> void:
	battle_bool = BattleBool.new(false)
