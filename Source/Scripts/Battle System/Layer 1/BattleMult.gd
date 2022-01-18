extends "res://Source/Scripts/Battle System/Layer 1/BattleFloat.gd"

func _concat(battle_var: Reference) -> void:
	battle_var.value = battle_var.value * value
