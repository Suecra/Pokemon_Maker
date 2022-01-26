extends "res://Source/Scripts/Battle System/Layer 1/BattleBool.gd"

const BattleBool = preload("res://Source/Scripts/Battle System/Layer 1/BattleBool.gd")

func _concat(battle_var: Reference) -> void:
	battle_var.value = battle_var.value && value

func _init(value: bool).(value) -> void:
	pass
