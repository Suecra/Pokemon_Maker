extends WATTest

const BattleAdd = preload("res://Source/Scripts/Battle System/Layer 1/BattleAdd.gd")
var battle_add: BattleAdd

func test_concat() -> void:
	var add2 = BattleAdd.new(7.5)
	battle_add._concat(add2)
	asserts.is_equal(12.5, battle_add.value)
	asserts.is_equal(20, add2.value)

func pre() -> void:
	battle_add = BattleAdd.new(12.5)
