extends "res://Source/Scripts/Battle System/Layer 1/BattleVar.gd"

var value: Array

func _concat(battle_var: Reference) -> void:
	battle_var.value = value

func _get_type() -> int:
	return L1Consts.MessageType.ARRAY

func _init(value: Array) -> void:
	self.value = value
