extends "res://Source/Scripts/Battle System/Layer 1/BattleNumber.gd"

func _concat(battle_var: Reference) -> void:
	battle_var.value = min(battle_var.value, value)

func _init(value: float).(value) -> void:
	pass
