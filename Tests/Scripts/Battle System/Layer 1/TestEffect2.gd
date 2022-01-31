extends Reference

const BattleAdd = preload("res://Source/Scripts/Battle System/Layer 1/BattleAdd.gd")

func call_test(test: int) -> BattleAdd:
	return BattleAdd.new(test * 2)
