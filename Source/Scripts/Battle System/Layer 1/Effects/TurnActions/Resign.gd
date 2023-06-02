extends "res://Source/Scripts/Battle System/Layer 1/Effects/FieldTurnAction.gd"

func _init() -> void:
	priority = 99
	set_name("Resign")

func do_action() -> void:
	owner.field.defeated = true
	battle.add_effect(battle.battle_l0.battlefield, "FieldEffects/Aborted")
