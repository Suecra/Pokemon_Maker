extends WATTest

const BattleArray = preload("res://Source/Scripts/Battle System/Layer 1/BattleArray.gd")
var battle_array: BattleArray

func test_concat() -> void:
	var arr2 = BattleArray.new([3, 4])
	battle_array._concat(arr2)
	asserts.is_true(battle_array.value.has(1))
	asserts.is_true(battle_array.value.has(2))
	asserts.is_true(arr2.value.has(1))
	asserts.is_true(arr2.value.has(2))

func pre() -> void:
	battle_array = BattleArray.new([1, 2])
