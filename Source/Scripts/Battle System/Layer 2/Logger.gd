extends Reference

const BattleL1 = preload("res://Source/Scripts/Battle System/Layer 1/Battle.gd")

var battle_l1: BattleL1

func init_battle() -> void:
	battle_l1.add_effect(battle_l1.battle_l0.battlefield, "LoggingEffects/DebugLogger")
