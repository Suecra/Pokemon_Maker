extends "res://Source/Scripts/Battle System/Layer 1/BattleVar.gd"

var value: bool

func _concat(battle_var: Reference) -> void:
	battle_var.value = value

func _get_type() -> int:
	return L1Consts.MessageType.BOOL

func _init(value: bool) -> void:
	self.value = value
