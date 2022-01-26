extends "res://Source/Scripts/Battle System/Layer 1/BattleArray.gd"

func _concat(battle_var: Reference) -> void:
	for item in value:
		battle_var.value.erase(item)

func _init(value: Array).(value) -> void:
	pass
