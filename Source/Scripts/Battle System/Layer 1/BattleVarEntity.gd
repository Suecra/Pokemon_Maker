extends "res://Source/Scripts/Battle System/Layer 1/BattleVar.gd"

const BattleEntity = preload("res://Source/Scripts/Battle System/Layer 0/BattleEntity.gd")

var value: BattleEntity

func _concat(battle_var: Reference) -> void:
	battle_var.value = value

func _init(value: BattleEntity) -> void:
	self.value = value
